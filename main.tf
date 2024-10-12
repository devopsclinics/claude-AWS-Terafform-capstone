provider "aws" {
  region = "us-west-1"
}

# Create a VPC
resource "aws_vpc" "default_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "mainvpc"
  }
}

# Security Group for Lambda
resource "aws_security_group" "lambda_sg" {
  vpc_id = aws_vpc.default_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lambda-security-group"
  }
}

# Create Public Subnets
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.default_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "publicsubnet${count.index + 1}"
  }
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  filename      = "lambda_function.zip"
  timeout       = 30
  memory_size   = 128

  vpc_config {
    security_group_ids = [aws_security_group.lambda_sg.id]
    subnet_ids         = aws_subnet.public[*].id
  }

  environment {
    variables = {
      ENV_VAR_KEY = "value"
    }
  }

  tags = {
    Name = "MyLambdaFunction"
  }
}

# IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "lambda_exec_role"
  }
}

# IAM Policy Attachment
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# ZIP the Lambda code
data "archive_file" "lambda_function" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_subnet" "private_web" {
  count             = 2
  vpc_id            = aws_vpc.default_vpc.id
  cidr_block        = "10.0.${count.index + 10}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "private web subnet ${count.index + 1}"
    Tier = "WEB"
  }
}
resource "aws_subnet" "private_app" {
  count             = 2
  vpc_id            = aws_vpc.default_vpc.id
  cidr_block        = "10.0.${count.index + 20}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "private app subnet ${count.index + 1}"
    Tier = "APP"
  }
}
resource "aws_subnet" "private_db" {
  count             = 2
  vpc_id            = aws_vpc.default_vpc.id
  cidr_block        = "10.0.${count.index + 30}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "private db subnet ${count.index + 1}"
    Tier = "DB"
  }
}
resource "aws_eip" "nat" {
  count = 2
  tags = {
    Name = "NAT Gateway EIP ${count.index + 1}"
  }
}
resource "aws_nat_gateway" "main" {
  count         = 2
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "NAT Gateway ${count.index + 1}"
  }
}
# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.default_vpc.id
  tags = {
    Name = "main internet gateway"
  }
}
# Create Route Tables
resource "aws_route_table" "private_web" {
  count  = 2
  vpc_id = aws_vpc.default_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }
  tags = {
    Name = "private web route table ${count.index + 1}"
  }
}
resource "aws_route_table" "private_app" {
  count  = 2
  vpc_id = aws_vpc.default_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }
  tags = {
    Name = "private app route table ${count.index + 1}"
  }
}
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.default_vpc.id
  tags = {
    Name = "db route table"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public route table"
  }
}
resource "aws_route_table_association" "private_web" {
  count          = 2
  subnet_id      = aws_subnet.private_web[count.index].id
  route_table_id = aws_route_table.private_web[count.index].id
}
resource "aws_route_table_association" "private_app" {
  count          = 2
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private_app[count.index].id
}
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "db" {
  count          = 2
  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.db.id
}
resource "aws_db_subnet_group" "db-sg" {
  name       = "db-sg"
  subnet_ids = aws_subnet.private_db[*].id
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "team-claude-bucket"
  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}
resource "aws_cloudfront_origin_access_identity" "example" {
  comment = "Origin Access Identity for my S3 bucket"
}
resource "aws_cloudfront_distribution" "my_distribution" {
  origin {
    domain_name = aws_s3_bucket.my_bucket.bucket_regional_domain_name
    origin_id   = "S3Origin"
    # Restrict access to the S3 bucket
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.example.id
    }
  }
  enabled             = true
  default_root_object = "index.html" # Change as needed
  default_cache_behavior {
    target_origin_id       = "S3Origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  tags = {
    Name        = "MyCloudFrontDistribution"
    Environment = "Production"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
