# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "app_dashboard" {
  dashboard_name = var.dashboard_name
  
  dashboard_body = jsonencode({
    "widgets" = [
      {
        "type" = "metric",
        "x" = 0,
        "y" = 0,
        "width" = 6,
        "height" = 6,
        "properties" = {
          "metrics" = [
            [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", aws_autoscaling_group.app_asg.name ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Average",
          "region" = var.region,  
          "title" = "Average CPU Utilization"
        }
      },
      {
        "type" = "metric",
        "x" = 6,
        "y" = 0,
        "width" = 6,
        "height" = 6,
        "properties" = {
          "metrics" = [
            [ "AWS/AutoScaling", "GroupInServiceInstances", "AutoScalingGroupName", aws_autoscaling_group.app_asg.name ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Sum",
          "region" = var.region,  
          "title" = "In-Service Instances"
        }
      },
      {
        "type" = "metric",
        "x" = 0,
        "y" = 6,
        "width" = 6,
        "height" = 6,
        "properties" = {
          "metrics" = [
            [ "AWS/AutoScaling", "GroupDesiredCapacity", "AutoScalingGroupName", aws_autoscaling_group.app_asg.name ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Average",
          "region" = var.region,  
          "title" = "Desired Capacity"
        }
      },
      {
        "type" = "metric",
        "x" = 6,
        "y" = 6,
        "width" = 6,
        "height" = 6,
        "properties" = {
          "metrics" = [
            [ "AWS/AutoScaling", "GroupMinSize", "AutoScalingGroupName", aws_autoscaling_group.app_asg.name ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Average",
          "region" = var.region,  
          "title" = "Minimum Size"
        }
      }
    ]
  })
}

# CloudWatch metric for high CPU usage
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high_cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.high_cpu_threshold

}

# CloudWatch metric for low CPU usage
resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low_cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.low_cpu_threshold

  
}

# CloudWatch Log Group for Application Logs
resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = var.log_group_name
  retention_in_days = var.log_retention_days  
}

# CloudWatch Log Stream
resource "aws_cloudwatch_log_stream" "app_log_stream" {
  name           = "app-log-stream"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
}
