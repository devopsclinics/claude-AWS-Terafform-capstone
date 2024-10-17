// RDS input Values

variable "allocated_storage" {
  description = "The allocated storage for the DB instance"
  type        = number
  default      = 10
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default = ""
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "The instance class to use for the DB instance"
  type        = string
  default     = "db.t3.micro"
}

variable "username" {
  description = "The username for the DB instance"
  type        = string
  default = ""

}

variable "password" {
  description = "The password for the DB instance"
  type        = string
 default      = ""
}

variable "parameter_group_name" {
  description = "The parameter group to associate with the DB instance"
  type        = string
  default     = "default.mysql8.0"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

# Define the variable for RDS backup retention period
variable "rds_backup_retention" {
  description = "The number of days to retain RDS backups"
  type        = number
  default     = 7  # You can modify this default value as needed
}

# Define the variable for VPC security group IDs
variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs for the RDS instance"
  type        = list(string)
}

# Define the variable for DB subnet group name
variable "db_subnet_group_name" {
  description = "The name of the DB subnet group to associate with the RDS instance"
  type        = string
}

# Optional: Define a variable for tags if you want flexibility in naming your RDS instance
variable "tags" {
  description = "A map of tags to associate with the RDS instance"
  type        = map(string)
  default     = {
    Name = "Claude RDS Instance"
  }
}

