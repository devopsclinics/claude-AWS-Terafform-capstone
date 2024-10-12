#RDS Variable (Check line 82 for S3 bucket variable)

# AWS Region
variable "aws_region" {
  description = "The AWS region where resources will be deployed."
  default     = "us-east-1"
}

# VPC CIDR block
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

# Subnet CIDR blocks
variable "subnet_a_cidr" {
  description = "CIDR block for subnet in Availability Zone A."
  default     = "10.0.1.0/24"
}

variable "subnet_b_cidr" {
  description = "CIDR block for subnet in Availability Zone B."
  default     = "10.0.3.0/24"
}

# Availability Zones
variable "availability_zone_a" {
  description = "Availability Zone for Subnet A."
  default     = "us-east-1a"
}

variable "availability_zone_b" {
  description = "Availability Zone for Subnet B."
  default     = "us-east-1b"
}

# RDS instance settings
variable "rds_instance_class" {
  description = "Instance class for the RDS instance."
  default     = "db.t4g.micro"
}

variable "rds_allocated_storage" {
  description = "Allocated storage size in GiB for the RDS instance."
  default     = 20
}

variable "rds_storage_type" {
  description = "Storage type for the RDS instance."
  default     = "gp3"
}

variable "rds_db_name" {
  description = "The name of the RDS database."
  default     = "claudedb"
}

variable "rds_username" {
  description = "Username for the RDS instance."
  default     = "claudeuser"
}

variable "rds_password" {
  description = "Password for the RDS instance."
  default     = "claudepassword"
  sensitive   = true
}

# Backup retention
variable "rds_backup_retention" {
  description = "Backup retention period in days."
  default     = 7
}

# CIDR block for security group ingress
variable "allowed_cidr" {
  description = "CIDR block allowed to access the RDS instance."
  default     = "0.0.0.0/0"
}


  #S3 Bucket Variable

  # Variable for the AWS region
variable "region" {
  description = "The AWS region where the S3 bucket will be created."
  type        = string
  default     = "us-east-1" # Change the default value to your preferred region
}

# Variable for the S3 bucket name
variable "bucket" {
  description = "The name of the S3 bucket to be created."
  type        = string
  default     = "claude-s3-bucket" # Change to the actual bucket name for the team
}

# Variable for the AWS KMS key deletion window
variable "aws_kms_key" {
  description = "The number of days before the AWS KMS key is deleted after scheduling."
  type        = number
  default     = 30 # You can modify this value based on your requirements
}

