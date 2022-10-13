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
  filename = "${path.module}/inventory"
}
# need to create the ceramic daemon config file
resource "local_file" "daemon_config" {
  content = templatefile("${path.module}/daemon-config.tpl", {
    network_name   = "${var.ceramic_network}"
    ceramic_bucket = aws_s3_bucket.ceramic_bucket.bucket,
    ipfs_host      = "http://${aws_instance.ipfs_node.public_ip}:5001"
  })
  filename = "${path.module}/daemon-config.json"
}
