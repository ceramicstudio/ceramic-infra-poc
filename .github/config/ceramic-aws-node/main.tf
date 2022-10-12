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
  region = "us-east-1"
}


resource "aws_s3_bucket" "ceramic_bucket" {
  bucket = var.ceramic_bucket_name
}

resource "aws_s3_bucket" "ipfs_bucket" {
  bucket = var.ipfs_bucket_name
}

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

resource "aws_instance" "ceramic_node" {
  ami           = "ami-08c40ec9ead489470" # us-west-2
  instance_type = "t2.micro"
  tags = {
    "name" = "Ceramic-Node"
  }
}

resource "aws_instance" "ipfs_node" {
  ami           = "ami-08c40ec9ead489470" # us-west-2
  instance_type = "t2.micro"
  tags = {
    "name" = "IPFS-Node"
  }
}

# create ansible inventory
resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    ceramic_node_ip = aws_instance.ceramic_node.public_ip,
    ipfs_node_ip    = aws_instance.ipfs_node.public_ip
  })
  filename = "${path.cwd}/inventory"
}
