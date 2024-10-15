variable "name" {
  description = "Name of the Auto Scaling group"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  
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


variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling group"
  type        = list(string)
}

variable "target_group_arns" {
  type = list(string)
  description = "List of target group ARNs for the autoscaling group"
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instances"
  type        = list(string)
  default     = [] 
}
