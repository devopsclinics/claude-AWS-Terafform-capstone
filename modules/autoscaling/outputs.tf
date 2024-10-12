output "autoscaling_group_id" {
  description = "ID of the Auto Scaling group"
  value       = aws_autoscaling_group.app.id
}
output "scale_up_policy_arn" {
  value = aws_autoscaling_policy.scale_up.arn
}

output "scale_down_policy_arn" {
  value = aws_autoscaling_policy.scale_down.arn
}
