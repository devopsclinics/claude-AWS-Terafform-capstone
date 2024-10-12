# update any values from here

region   = "us-east-2"

# auto scaling
web_name = "web-tier"
app_name = "app-tier"
# my home ip address
my_ip   = "" # Enter your up block
# my region ami - amazon linux
ami_id  = "ami-037774efca2da0726" # this ami is related to us-east-2 region. Check if it's available in your region.
# autoscaling size and capacity
min_size = 2
max_size = 5
desired_capacity = 2
# my private key 
key_name = "" # enter your key pair for all instances
# EC2 instance type
instance_type = "t2.micro"

# cloudwatch
dashboard_name        = "claude-dashboard"
dashboard_period      = 300
evaluation_periods    = 2
alarm_period          = 300
high_cpu_threshold    = 80
low_cpu_threshold     = 20
log_group_name        = "claude-log-group"
log_retention_days    = 7
