output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "web_tier_sg_id" {
  value = aws_security_group.web_tier.id
}

output "internal_alb_sg_id" {
  value = aws_security_group.internal_alb.id
}

output "app_tier_sg_id" {
  value = aws_security_group.app_tier.id
}

output "db_tier_sg_id" {
  value = aws_security_group.db_tier.id
}
