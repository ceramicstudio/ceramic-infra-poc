

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
