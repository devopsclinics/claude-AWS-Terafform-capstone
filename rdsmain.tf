# Configure AWS credentials
provider "aws" {
  region = var.aws_region  # Use variable for the region
}

# Create a VPC
resource "aws_vpc" "claude" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "Claude VPC"
  }
}

# Subnet in us-east-1a
resource "aws_subnet" "public_a" {
  cidr_block         = var.subnet_a_cidr
  vpc_id             = aws_vpc.claude.id
  availability_zone  = var.availability_zone_a

  tags = {
    Name = "Public Subnet A"
  }
}

# Subnet in us-east-1b
resource "aws_subnet" "public_b" {
  cidr_block         = var.subnet_b_cidr
  vpc_id             = aws_vpc.claude.id
  availability_zone  = var.availability_zone_b

  tags = {
    Name = "Public Subnet B"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "claude" {
  name       = "claude-rds-subnet-group"
  subnet_ids = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  tags = {
    Name = "Claude RDS Subnet Group"
  }
}

# Create a security group
resource "aws_security_group" "claude" {
  name        = "rds-sg"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.claude.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  tags = {
    Name = "Claude RDS Security Group"
  }
}

# Create an RDS instance
resource "aws_db_instance" "claude" {
  identifier             = "claude-rds-instance"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  storage_type           = var.rds_storage_type
  db_name                = var.rds_db_name
  username               = var.rds_username
  password               = var.rds_password
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.claude.id]
  backup_retention_period = var.rds_backup_retention
  db_subnet_group_name   = aws_db_subnet_group.claude.name

  tags = {
    Name = "Claude RDS Instance"
  }
}
