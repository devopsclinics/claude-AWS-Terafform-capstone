// outputs.tf

output "db_instance_identifier" {
  description = "The identifier of the DB instance"
  value       = aws_db_instance.default.id
}

output "db_instance_endpoint" {
  description = "The endpoint of the DB instance"
  value       = aws_db_instance.default.endpoint
}

output "db_instance_port" {
  description = "The port for the DB instance"
  value       = aws_db_instance.default.port
}

output "db_instance_status" {
  description = "The current status of the DB instance"
  value        = aws_db_instance.default.status
}
