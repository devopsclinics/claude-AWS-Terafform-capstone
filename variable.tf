# VPC variables
variable "name" {
  description = "The name for the VPC and resources"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "az1" {
  description = "First Availability Zone"
  type        = string
}

variable "az2" {
  description = "Second Availability Zone"
  type        = string
}

variable "public_subnet_cidr_az1" {
  description = "CIDR block for the public subnet in AZ1"
  type        = string
}

variable "private_subnet_cidr_az1_1" {
  description = "CIDR block for the first private subnet in AZ1"
  type        = string
}

variable "private_subnet_cidr_az1_2" {
  description = "CIDR block for the second private subnet in AZ1"
  type        = string
}

variable "public_subnet_cidr_az2" {
  description = "CIDR block for the public subnet in AZ2"
  type        = string
}

variable "private_subnet_cidr_az2_1" {
  description = "CIDR block for the first private subnet in AZ2"
  type        = string
}

variable "private_subnet_cidr_az2_2" {
  description = "CIDR block for the second private subnet in AZ2"
  type        = string
}

variable "private_db_subnet_cidr_az1" {
  description = "CIDR block for the private database subnet in AZ1"
  type        = string
}

variable "private_db_subnet_cidr_az2" {
  description = "CIDR block for the private database subnet in AZ2"
  type        = string
}