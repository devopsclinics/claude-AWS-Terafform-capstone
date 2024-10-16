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
