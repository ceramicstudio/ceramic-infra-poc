# Create the security groups for ceramic and ipfs nodes
resource "aws_security_group" "ceramic_security_group" {
  name        = "ceramic security group"
  description = "Allow inbound traffic from the internet to ceramic"
}

resource "aws_security_group" "ipfs_security_group" {
  name        = "ipfs security group"
  description = "Allow inbound traffic from the internet to ipfs"
}

# create security group rule for ceramic_security_group

resource "aws_security_group_rule" "ceramic_port" {
  type              = "ingress"
  from_port         = 7007
  to_port           = 7007
  protocol          = "tcp"
  security_group_id = aws_security_group.ceramic_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ceramic_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.ceramic_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "ceramic_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.ceramic_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}


# create security group rule for ipfs_security_group
resource "aws_security_group_rule" "ipfs_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.ipfs_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ipfs_api" {
  type              = "ingress"
  from_port         = 5001
  to_port           = 5001
  protocol          = "tcp"
  security_group_id = aws_security_group.ipfs_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ipfs_healthcheck" {
  type              = "ingress"
  from_port         = 8011
  to_port           = 8011
  protocol          = "tcp"
  security_group_id = aws_security_group.ipfs_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ipfs_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.ipfs_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

