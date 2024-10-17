# Create an RDS instance

resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  publicly_accessible    = false
  vpc_security_group_ids = var.vpc_security_group_ids
  backup_retention_period = var.rds_backup_retention
  db_subnet_group_name   = var.db_subnet_group_name
  tags = var.tags
}

