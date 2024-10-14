variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created."
  type        = string
}

variable "my_ip" {
  description = "Your IP address in CIDR notation for Bastion host access."
  type        = string
}
