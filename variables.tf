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

# autoscaling
variable "my_ip" {
  description = "Your Home IP address in CIDR notation for Bastion host access."
  type        = string
}

variable "web_name" {
  description = "The name of web-tier auto scaling."
  type        = string
}

variable "app_name" {
  description = "The name of app-tier auto scaling."
  type        = string
}
variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "The instance key pem"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling group"
  type        = number
}

# cloudwatch
variable "dashboard_name" {
  type        = string
  description = "Name of the CloudWatch dashboard"
}

variable "dashboard_period" {
  type        = number
  description = "The period for CloudWatch metrics"
}

variable "evaluation_periods" {
  type        = number
  description = "The evaluation periods for CloudWatch alarms"
}

variable "alarm_period" {
  type        = number
  description = "The period for CloudWatch alarms"
}

variable "high_cpu_threshold" {
  type        = number
  description = "Threshold for high CPU usage"
}

variable "low_cpu_threshold" {
  type        = number
  description = "Threshold for low CPU usage"
}

variable "log_group_name" {
  type        = string
  description = "Name of the CloudWatch log group"
}

variable "log_retention_days" {
  type        = number
  description = "Number of days to retain CloudWatch logs"
}

# database monitor
# variable "db_instance_identifier" {
#   type        = string
#   description = "RDS instance identifier for monitoring"
# }

# variable "rds_scale_up_policy_arn" {
#   type        = string
#   description = "ARN of the scale-up policy for the web tier"
# }

# variable "rds_scale_down_policy_arn" {
#   type        = string
#   description = "ARN of the scale-down policy for the web tier"
# }