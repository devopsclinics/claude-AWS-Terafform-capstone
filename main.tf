provider "aws" {
  region = "us-east-1"
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


data "aws_availability_zones" "available" {
  state = "available"
}
