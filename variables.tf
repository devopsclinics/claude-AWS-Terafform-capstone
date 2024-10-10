variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = "project-log-group"
}

variable "log_retention_days" {
  description = "Number of days to retain logs"
  type        = number
  default     = 14
}

variable "evaluation_periods" {
  description = "Number of periods to evaluate for alarms"
  type        = number
  default     = 2
}

variable "alarm_period" {
  description = "Time period for each evaluation in seconds"
  type        = number
  default     = 120
}

variable "high_cpu_threshold" {
  description = "CPU utilization threshold for high CPU alarm"
  type        = number
  default     = 75
}

variable "low_cpu_threshold" {
  description = "CPU utilization threshold for low CPU alarm"
  type        = number
  default     = 25
}

variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
  default     = "projectDashboard"
}

variable "dashboard_period" {
  description = "Time period for metrics in seconds"
  type        = number
  default     = 300
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}