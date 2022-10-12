
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
