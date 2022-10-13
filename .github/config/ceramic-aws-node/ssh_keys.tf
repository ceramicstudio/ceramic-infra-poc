resource "aws_key_pair" "ansible" {
  key_name   = "ansible-key"
  public_key = var.ansible_public_key
}
