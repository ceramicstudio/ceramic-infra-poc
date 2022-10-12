terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_default_region
}

# Create s3 buckets for persistent data storage
# TODO: optimize this into a single block that creates both buckets

resource "aws_s3_bucket" "ceramic_bucket" {
  bucket = var.ceramic_bucket_name
}

resource "aws_s3_bucket" "ipfs_bucket" {
  bucket = var.ipfs_bucket_name
}

# Create a role for each ec2 node to be able to use the s3 buckets
resource "aws_iam_role" "ceramic_s3_access_role" {
  name = "s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        sid = ""
      },
    ]
  })
}

resource "aws_iam_role" "ipfs_s3_access_role" {
  name = "s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        sid = ""
      },
    ]
  })
}

# create an instance profile that will be attached to each ec2 node
resource "aws_iam_instance_profile" "ceramic_instance_profile" {
  name = "ceramic instance profile"
  role = aws_iam_role.ceramic_s3_access_role.name
}

resource "aws_iam_instance_profile" "ipfs_instance_profile" {
  name = "ipfs instance profile"
  role = aws_iam_role.ipfs_s3_access_role.name
}

# Create the iam policy that will be attached to the ec2_s3_access_role
resource "aws_iam_policy" "ceramic_policy" {
  name        = "ceramic_s3_policy"
  path        = "/"
  description = "s3 policy for ceramic node"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.ceramic_bucket.arn}/*",
          "${aws_s3_bucket.ceramic_bucket.arn}"
        ]
      },
    ]
  })
}

resource "aws_iam_policy" "ipfs_policy" {
  name        = "ipfs_s3_policy"
  path        = "/"
  description = "s3 policy for ipfs node"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.ipfs_bucket.arn}/*",
          "${aws_s3_bucket.ipfs_bucket.arn}"
        ]
      },
    ]
  })
}

# Attach the policy to the role

resource "aws_iam_policy_attachment" "ceramic_attach" {
  name       = "ceramic_attachment"
  roles      = ["${aws_iam_role.ceramic_s3_access_role.name}"]
  policy_arn = aws_iam_policy.ceramic_policy.arn
}

resource "aws_iam_policy_attachment" "ipfs-attach" {
  name       = "ipfs-attachment"
  roles      = ["${aws_iam_role.ipfs_s3_access_role.name}"]
  policy_arn = aws_iam_policy.ipfs_policy.arn
}

# Create instance profiles for each node
resource "aws_iam_instance_profile" "ceramic_instance_profile" {
  name = "ceramic instance profile"
  role = aws_iam_role.ceramic_s3_access_role.name
}

resource "aws_iam_instance_profile" "ipfs_instance_profile" {
  name = "ipfs instance profile"
  role = aws_iam_role.ipfs_s3_access_role.name
}

# Create the security groups for ceramic and ipfs nodes
resource "aws_security_group" "ceramic_security_group" {
  name        = "ceramic security group"
  description = "Allow inbound traffic from the internet to ceramic"

  ingress {
    description = "Allow inbound traffic from the internet to ceramic"
    from_port   = 0
    to_port     = 7007
    protocol    = "tcp"

  }
}

resource "aws_security_group" "ipfs_security_group" {
  name        = "ipfs security group"
  description = "Allow inbound traffic from the internet to ipfs"

  ingress {
    description = "Allow inbound traffic from the internet to ipfs healthcheck port"
    from_port   = 0
    to_port     = 8011
    protocol    = "tcp"

  }
  ingress {
    description = "Allow inbound traffic from the internet to ipfs api port"
    from_port   = 0
    to_port     = 5001
    protocol    = "tcp"

  }
}
# for each of these instances we need to attach the appropriate s3 policy
# for each of these instnaces we need to open up the appropriate ports
resource "aws_instance" "ceramic_node" {
  ami           = "ami-08c40ec9ead489470" # us-west-2
  instance_type = "t2.micro"
  tags = {
    "name" = "Ceramic-Node"
  }
  security_groups      = ["${aws_security_group.ceramic_security_group.id}"]
  iam_instance_profile = aws_iam_instance_profile.ceramic_instance_profile.name

}

resource "aws_instance" "ipfs_node" {
  ami           = "ami-08c40ec9ead489470" # us-west-2
  instance_type = "t2.micro"
  tags = {
    "name" = "IPFS-Node"
  }
  security_groups      = ["${aws_security_group.ipfs_security_group.id}"]
  iam_instance_profile = aws_iam_instance_profile.ipfs_instance_profile.name
}

# create ansible inventory
resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    ceramic_node_ip = aws_instance.ceramic_node.public_ip,
    ipfs_node_ip    = aws_instance.ipfs_node.public_ip
  })
  filename = "${path.cwd}/inventory"
}
# need to create the ceramic daemon config file
# resource "local_file" "inventory" {
#   content = templatefile("${path.module}/inventory.tpl", {
#     ceramic_node_ip = aws_instance.ceramic_node.public_ip,
#     ipfs_node_ip    = aws_instance.ipfs_node.public_ip
#   })
#   filename = "${path.cwd}/inventory"
# }
