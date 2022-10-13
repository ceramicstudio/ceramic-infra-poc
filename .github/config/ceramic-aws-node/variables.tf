variable "ipfs_bucket_name" {
  type        = string
  description = "The name of the S3 bucket that will be used to store IPFS data"

}

variable "ceramic_bucket_name" {
  type        = string
  description = "The name of the S3 bucket that will be used to store Ceramic data"

}

variable "ceramic_network" {
  type        = string
  description = "The Ceramic network to use"

}

variable "ansible_public_key" {
  type        = string
  description = "The public key to use for the ansible user"
}

