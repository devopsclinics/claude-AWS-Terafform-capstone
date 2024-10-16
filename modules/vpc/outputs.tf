# subnets output
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_az1.id,
    aws_subnet.public_subnet_az2.id,
  ]
}
output "public_subnet_az1" {
  description = "Public Subnet in AZ1"
  value       = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2" {
  description = "Public Subnet in AZ2"
  value       = aws_subnet.public_subnet_az2.id
}

output "web_private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_az1_1.id,
    aws_subnet.private_subnet_az2_1.id,
  ]
}

output "private_subnet_az1_1" {
  description = "Private Subnet 1 in AZ1"
  value       = aws_subnet.private_subnet_az1_1.id
}

output "private_subnet_az1_2" {
  description = "Private Subnet 2 in AZ1"
  value       = aws_subnet.private_subnet_az1_2.id
}

output "app_private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_az1_2.id,
    aws_subnet.private_subnet_az2_2.id,
  ]
}

output "private_subnet_az2_1" {
  description = "Private Subnet 1 in AZ2"
  value       = aws_subnet.private_subnet_az2_1.id
}

output "private_subnet_az2_2" {
  description = "Private Subnet 2 in AZ2"
  value       = aws_subnet.private_subnet_az2_2.id
}

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