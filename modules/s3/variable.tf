# Variable for the S3 bucket name
variable "bucket" {
  description = "The name of the S3 bucket to be created."
  type        = string
  default     = "" # Change to the actual bucket name for the team
}

# Variable for the AWS KMS key deletion window
variable "aws_kms_key" {
  description = "The number of days before the AWS KMS key is deleted after scheduling."
  type        = number
  default     = "0"
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "" 
}