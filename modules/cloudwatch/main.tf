
resource "aws_cloudwatch_dashboard" "app_dashboard" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    "widgets" = [
      # Web Tier Metrics
      {
        "type" = "metric",
        "x" = 0,
        "y" = 0,
        "width" = 6,
        "height" = 6,
        "properties" = {
          "metrics" = [
            [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.web_autoscaling_group_id ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Average",
          "region" = var.region,
          "title" = "Web Tier Average CPU Utilization"
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
            [ "AWS/AutoScaling", "GroupInServiceInstances", "AutoScalingGroupName", var.web_autoscaling_group_id ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Sum",
          "region" = var.region,
          "title" = "Web Tier In-Service Instances"
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
            [ "AWS/AutoScaling", "GroupDesiredCapacity", "AutoScalingGroupName", var.web_autoscaling_group_id ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Average",
          "region" = var.region,
          "title" = "Web Tier Desired Capacity"
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
            [ "AWS/AutoScaling", "GroupMinSize", "AutoScalingGroupName", var.web_autoscaling_group_id ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Average",
          "region" = var.region,
          "title" = "Web Tier Minimum Size"
        }
      },
      # Application Tier Metrics
      {
        "type" = "metric",
        "x" = 0,
        "y" = 12,
        "width" = 6,
        "height" = 6,
        "properties" = {
          "metrics" = [
            [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.app_autoscaling_group_id ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Average",
          "region" = var.region,
          "title" = "App Tier Average CPU Utilization"
        }
      },
      {
        "type" = "metric",
        "x" = 6,
        "y" = 12,
        "width" = 6,
        "height" = 6,
        "properties" = {
          "metrics" = [
            [ "AWS/AutoScaling", "GroupInServiceInstances", "AutoScalingGroupName", var.app_autoscaling_group_id ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Sum",
          "region" = var.region,
          "title" = "App Tier In-Service Instances"
        }
      },
      {
        "type" = "metric",
        "x" = 0,
        "y" = 18,
        "width" = 6,
        "height" = 6,
        "properties" = {
          "metrics" = [
            [ "AWS/AutoScaling", "GroupDesiredCapacity", "AutoScalingGroupName", var.app_autoscaling_group_id ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Average",
          "region" = var.region,
          "title" = "App Tier Desired Capacity"
        }
      },
      {
        "type" = "metric",
        "x" = 6,
        "y" = 18,
        "width" = 6,
        "height" = 6,
        "properties" = {
          "metrics" = [
            [ "AWS/AutoScaling", "GroupMinSize", "AutoScalingGroupName", var.app_autoscaling_group_id ]
          ],
          "period" = var.dashboard_period,
          "stat" = "Average",
          "region" = var.region,
          "title" = "App Tier Minimum Size"
        }
      },
      # RDS CPU Utilization
      # {
      #   "type" = "metric",
      #   "x" = 0,
      #   "y" = 12,
      #   "width" = 6,
      #   "height" = 6,
      #   "properties" = {
      #     "metrics" = [
      #       [ "AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", var.db_instance_identifier ]
      #     ],
      #     "period" = var.dashboard_period,
      #     "stat" = "Average",
      #     "region" = var.region,
      #     "title" = "RDS CPU Utilization"
      #   }
      # },
      # # RDS Free Storage Space
      # {
      #   "type" = "metric",
      #   "x" = 6,
      #   "y" = 12,
      #   "width" = 6,
      #   "height" = 6,
      #   "properties" = {
      #     "metrics" = [
      #       [ "AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", var.db_instance_identifier ]
      #     ],
      #     "period" = var.dashboard_period,
      #     "stat" = "Average",
      #     "region" = var.region,
      #     "title" = "RDS Free Storage Space"
      #   }
      # },
      # # RDS Database Connections
      # {
      #   "type" = "metric",
      #   "x" = 12,
      #   "y" = 12,
      #   "width" = 6,
      #   "height" = 6,
      #   "properties" = {
      #     "metrics" = [
      #       [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", var.db_instance_identifier ]
      #     ],
      #     "period" = var.dashboard_period,
      #     "stat" = "Sum",
      #     "region" = var.region,
      #     "title" = "RDS Database Connections"
      #   }
      # }
    ]
  })
}


resource "aws_cloudwatch_metric_alarm" "high_cpu_web" {
  alarm_name          = "high_cpu_web"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.high_cpu_threshold
  alarm_actions       = [var.web_scale_up_policy_arn]

  dimensions = {
    AutoScalingGroupName = var.web_autoscaling_group_id
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_web" {
  alarm_name          = "low_cpu_web"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.low_cpu_threshold
  alarm_actions       = [var.web_scale_down_policy_arn]

  dimensions = {
    AutoScalingGroupName = var.web_autoscaling_group_id
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_app" {
  alarm_name          = "high_cpu_app"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.high_cpu_threshold
  alarm_actions       = [var.app_scale_up_policy_arn]

  dimensions = {
    AutoScalingGroupName = var.app_autoscaling_group_id
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_app" {
  alarm_name          = "low_cpu_app"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.low_cpu_threshold
  alarm_actions       = [var.app_scale_down_policy_arn]

  dimensions = {
    AutoScalingGroupName = var.app_autoscaling_group_id
  }
}

# RDS Alarm
# resource "aws_cloudwatch_metric_alarm" "rds_high_cpu" {
#   alarm_name          = "rds_high_cpu"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = var.evaluation_periods
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/RDS"
#   period              = var.alarm_period
#   statistic           = "Average"
#   threshold           = var.high_cpu_threshold
#   alarm_actions       = [var.rds_scale_up_policy_arn]

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_identifier
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "rds_low_storage" {
#   alarm_name          = "rds_low_storage"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = var.evaluation_periods
#   metric_name         = "FreeStorageSpace"
#   namespace           = "AWS/RDS"
#   period              = var.alarm_period
#   statistic           = "Average"
#   threshold           = 10000000000  # Adjust threshold based on our storage requirements (e.g., 10GB)
#   alarm_actions       = [var.rds_scale_down_policy_arn]

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_identifier
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "rds_high_connections" {
#   alarm_name          = "rds_high_connections"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = var.evaluation_periods
#   metric_name         = "DatabaseConnections"
#   namespace           = "AWS/RDS"
#   period              = var.alarm_period
#   statistic           = "Sum"
#   threshold           = 100  # Adjust threshold based on your expected number of connections
#   alarm_actions       = [var.rds_scale_up_policy_arn]

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_identifier
#   }
# }


# resource "aws_cloudwatch_log_group" "app_log_group" {
#   name              = var.log_group_name
#   retention_in_days = var.log_retention_days
# }

# resource "aws_cloudwatch_log_stream" "app_log_stream" {
#   name           = "app-log-stream"
#   log_group_name = aws_cloudwatch_log_group.app_log_group.name
# }
