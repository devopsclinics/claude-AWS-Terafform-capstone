# declare aws region
variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
}

# autoscaling
variable "my_ip" {
  description = "Your IP address in CIDR notation for Bastion host access."
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

# cloud watch
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