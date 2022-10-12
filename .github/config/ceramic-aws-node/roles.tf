# Create a role for each ec2 node to be able to use the s3 buckets
resource "aws_iam_role" "ceramic_s3_access_role" {
  name = "ceramic-s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role" "ipfs_s3_access_role" {
  name = "ipfs-s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
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
