# create an instance profile that will be attached to each ec2 node
resource "aws_iam_instance_profile" "ceramic_instance_profile" {
  name = "ceramic-instance-profile"
  role = aws_iam_role.ceramic_s3_access_role.name
}

resource "aws_iam_instance_profile" "ipfs_instance_profile" {
  name = "ipfs-instance-profile"
  role = aws_iam_role.ipfs_s3_access_role.name
}
