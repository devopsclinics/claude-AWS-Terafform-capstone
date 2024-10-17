# RDS outputs

output "rds_instance_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "rds_instance_port" {
  description = "Port of the RDS instance"
  value       = module.rds.db_instance_port
}

output "rds_instance_status" {
  description = "Status of the RDS instance"
  value       = module.rds.db_instance_status
}

output "rds_instance_identifier" {
  description = "Identifier of the RDS instance"
  value       = module.rds.db_instance_identifier
}
