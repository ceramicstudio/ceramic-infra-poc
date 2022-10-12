# Create s3 buckets for persistent data storage
# TODO: optimize this into a single block that creates both buckets

resource "aws_s3_bucket" "ceramic_bucket" {
  bucket = var.ceramic_bucket_name
}

resource "aws_s3_bucket" "ipfs_bucket" {
  bucket = var.ipfs_bucket_name
}
