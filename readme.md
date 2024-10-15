
# AWS CloudWatch Configurations Documentation

## 1. Log Groups

### Description
Log groups in AWS CloudWatch organize and store logs from various sources.

### Terraform Configuration
```hcl
resource "aws_cloudwatch_log_group" "app_log_group" {
  name_prefix        = "app-log-group-"
  retention_in_days  = var.log_retention_days

  
}
```
### Parameters
- **log_retention_days**: Number of days to retain log events.


---

## 2. Alarms
### Description
CloudWatch alarms monitor metrics and trigger actions based on conditions.

### Terraform Configuration
```hcl
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPUAlarm"
  comparison_operator  = "GreaterThanThreshold"
  evaluation_periods   = var.evaluation_periods
  metric_name          = "CPUUtilization"
  namespace            = "AWS/EC2"
  period               = var.period
  statistic            = "Average"
  threshold            = var.high_cpu_threshold

}
```
### Parameters
- **evaluation_periods**: Number of periods for data evaluation.
- **period**: Granularity of the alarm's metric.
- **high_cpu_threshold**: CPU utilization threshold.

---

## 3. Dashboards
### Description
Dashboards provide a customizable view of metrics and alarms.

### Terraform Configuration
```hcl
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

```
### Parameters
- **dashboard_name**: Name of the dashboard.
- **dashboard_period**: Period for metrics displayed on the dashboard.
- **region**: AWS region where resources are located.

---

## Summary
- **Flexibility**: Configurations are parameterized for easy adjustments.
- **Monitoring**: Covers logging, monitoring, and visualization.

## Conclusion
This documentation provides an overview of AWS CloudWatch configurations for managing log groups, alarms, and dashboards.
