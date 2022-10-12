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
