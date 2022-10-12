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
  ingress {
    description = "Allow inbound traffic from the internet to ssh"
    from_port   = 0
    to_port     = 22
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
  ingress {
    description = "Allow inbound traffic from the internet to ssh"
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"

  }
}
