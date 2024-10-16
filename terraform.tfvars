# vpc tfvars
name = "claude"
region = "us-east-2"
vpc_cidr = "10.0.0.0/16"
az1 = "us-east-2a"
az2 = "us-east-2b"
public_subnet_cidr_az1 = "10.0.1.0/24"
public_subnet_cidr_az2 = "10.0.5.0/24"
private_subnet_cidr_az1_1 = "10.0.2.0/24"
private_subnet_cidr_az1_2 = "10.0.6.0/24"
private_subnet_cidr_az2_1 = "10.0.3.0/24"
private_subnet_cidr_az2_2 = "10.0.7.0/24"
private_db_subnet_cidr_az1 = "10.0.4.0/24"
private_db_subnet_cidr_az2 = "10.0.8.0/24"# update any values from here


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
key_name = "test" # enter your prefered key-pair name for all instances. A .pem file will be created with the name you specified
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

#db
# db_instance_identifier = "claude"