resource "aws_launch_template" "app" {
  name          = "${var.name}-launch-template"
  image_id      = var.ami_id          
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data = filebase64("${path.module}/userdata.sh")

  lifecycle {
    create_before_destroy = true
  }


  # Adding security groups
  vpc_security_group_ids = var.vpc_security_group_ids
  

}

resource "aws_autoscaling_group" "app" {
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids

  tag {
    key                 = "Name"
    value               = "${var.name}-autoscaling-group"
    propagate_at_launch = true
  }
  
  # Attach to Load Balancer Target Group
  target_group_arns = var.target_group_arns 

}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.name}-scale-up"
  scaling_adjustment      = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app.name
  }

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.name}-scale-down"
  scaling_adjustment      = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app.name
}
