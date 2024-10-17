# RDS subnet output
output "private_db_subnet_az1" {
  description = "Private Subnet 1 in AZ1"
  value       = aws_subnet.private_db_subnet_az1
}

output "private_db_subnet_az2" {
  description = "Private Subnet 2 in AZ1"
  value       = aws_subnet.private_db_subnet_az2
}

output "db_private_subnet_ids" {
    description = "Use if deploying RDS in two availability zones"
  value = [
    aws_subnet.private_db_subnet_az1.id,
    aws_subnet.private_db_subnet_az2.id,
  ]
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main_vpc.id
}

output "db_subnet_group" {
  description = "db subnet group"
  value = aws_db_subnet_group.claude.name
}