# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.claude.id
}

# Output the Subnet IDs
output "subnet_a_id" {
  description = "The ID of the public subnet A."
  value       = aws_subnet.public_a.id
}

output "subnet_b_id" {
  description = "The ID of the public subnet B."
  value       = aws_subnet.public_b.id
}

# Output the RDS instance endpoint
output "rds_endpoint" {
  description = "The endpoint of the RDS instance."
  value       = aws_db_instance.claude.endpoint
}

# Output the RDS instance ID
output "rds_instance_id" {
  description = "The ID of the RDS instance."
  value       = aws_db_instance.claude.id
}
