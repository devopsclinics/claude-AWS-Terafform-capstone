

# AWS CloudWatch Configurations Documentation Terraform Capstone Claude

## 1. Log Groups

### Description
Log groups in AWS CloudWatch are utilized to organize and store logs from various sources, including EC2 instances, Lambda functions, and other AWS services.

### Terraform Configuration
```hcl
resource "aws_cloudwatch_log_group" "app_log_group" {
  name               = "var.app-log-group"
  retention_in_days  = var.log_retention_days  # To set retention period

}
```

### Parameters
- **log_retention_days**: Number of days to keep log events (e.g., 30, 90).


---

## 2. Alarms

### Description
CloudWatch alarms monitor specific metrics and can automatically execute actions based on defined conditions, such as scaling resources or sending notifications.

### Terraform Configuration
```hcl
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPUAlarm"
  comparison_operator  = "GreaterThanThreshold"
  evaluation_periods   = var.evaluation_periods  # Flexible parameter
  metric_name          = "CPUUtilization"
  namespace            = "AWS/EC2"
  period               = var.period               # Set period
  statistic            = "Average"
  threshold            = var.high_cpu_threshold   # Set threshold

}
```

### Parameters
- **evaluation_periods**: Number of periods for data evaluation (e.g., 2).
- **period**: Granularity in seconds of the metric (e.g., 60, 120).
- **high_cpu_threshold**: CPU utilization percentage that triggers the alarm (e.g., 75).

---

## 3. Dashboards

### Description
AWS CloudWatch dashboards provide a customizable interface for visualizing CloudWatch metrics and alarms, helping users monitor application health and performance.

### Terraform Configuration
```hcl
resource "aws_cloudwatch_dashboard" "app_dashboard" {
  dashboard_name = "AppDashboard"
  
  dashboard_body = jsonencode({
    widgets = [
      {
        type     = "metric",
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", aws_autoscaling_group.app_asg.name],
            ["AWS/EC2", "NetworkIn", "AutoScalingGroupName", aws_autoscaling_group.app_asg.name],
            ["AWS/EC2", "NetworkOut", "AutoScalingGroupName", aws_autoscaling_group.app_asg.name],
            ["AWS/EC2", "StatusCheckFailed", "AutoScalingGroupName", aws_autoscaling_group.app_asg.name]
          ],
          period = var.dashboard_period,  # Set period
          stat   = "Average",
          title  = "EC2 Metrics"
        }
      }
    ]
  })
}
```

### Parameters
- **dashboard_period**: Period for metrics displayed on the dashboard (e.g., 300 for 5 minutes).

---

## Summary
- **Flexibility**: Configurations are parameterized for easy adjustments to log retention, threshold limits, evaluation periods, and other parameters.
- **Monitoring**: Covers logging, monitoring, and visualization, essential for maintaining AWS resource health and performance.
