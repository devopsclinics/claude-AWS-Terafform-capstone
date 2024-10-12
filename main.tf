# Call the Security Groups module
module "security_group" {
  source   = "./modules/security_group"
  vpc_id   = module.vpc.vpc_id
  my_ip    = var.my_ip
}

# Call the Autoscaling module for web
module "web_autoscaling" {
  source         = "./modules/autoscaling"
  # Reference the private subnet IDs output
  subnet_ids     = module.vpc.web_private_subnet_ids  
  name           = var.web_name
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  min_size       = var.min_size
  max_size       = var.max_size
  desired_capacity = var.desired_capacity
  key_name       = var.key_name
   
  
  # Pass the target group ARN from the Load Balancer module
  target_group_arns = []# Add loadbalancer
}

  # Data source to get the instances in the Auto Scaling group for web tier
  data "aws_autoscaling_group" "web-tier-instance-id" {
  name = module.web_autoscaling.autoscaling_group_id
}



# Call the Autoscaling module for app
module "app_autoscaling" {
  source         = "./modules/autoscaling"
  # Reference the private subnet IDs output
  subnet_ids     = module.vpc.app_private_subnet_ids 
  name           = var.app_name
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  min_size       = var.min_size
  max_size       = var.max_size
  desired_capacity = var.desired_capacity
  key_name       = var.key_name
  vpc_security_group_ids = [module.security_group.app_tier_sg_id ]
    
  # Pass the target group ARN from the Load Balancer module
  target_group_arns = []# Add loadbalancer
}



# call cloudwatch module
module "cloudwatch" {
  source                = "./modules/cloudwatch"

  # Monitoring web tier
  web_autoscaling_group_id    = module.web_autoscaling.autoscaling_group_id
  web_scale_up_policy_arn     = module.web_autoscaling.scale_up_policy_arn
  web_scale_down_policy_arn   = module.web_autoscaling.scale_down_policy_arn

  # Monitoring application tier
  app_autoscaling_group_id    = module.app_autoscaling.autoscaling_group_id
  app_scale_up_policy_arn     = module.app_autoscaling.scale_up_policy_arn
  app_scale_down_policy_arn   = module.app_autoscaling.scale_down_policy_arn  

  dashboard_name        = var.dashboard_name
  region                = var.region
  dashboard_period      = var.dashboard_period
  evaluation_periods    = var.evaluation_periods
  alarm_period          = var.alarm_period
  high_cpu_threshold    = var.high_cpu_threshold
  low_cpu_threshold     = var.low_cpu_threshold
  
  log_group_name        = var.log_group_name
  log_retention_days    = var.log_retention_days
}
