# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.name}-igw"
  }
}

# Public Subnets and NAT Gateway for AZ1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr_az1
  availability_zone       = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-az1"
  }
}

resource "aws_eip" "nat_eip_az1" {
  #vpc = true
}

resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id = aws_eip.nat_eip_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id
  tags = {
    Name = "${var.name}-nat-gateway-az1"
  }
}

# Private Subnets for AZ1
resource "aws_subnet" "private_subnet_az1_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr_az1_1
  availability_zone = var.az1
  tags = {
    Name = "${var.name}-private-az1-1"
  }
}

resource "aws_subnet" "private_subnet_az1_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr_az1_2
  availability_zone = var.az1
  tags = {
    Name = "${var.name}-private-az1-2"
  }
}

resource "aws_subnet" "private_db_subnet_az1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_db_subnet_cidr_az1
  availability_zone = var.az1
  tags = {
    Name = "${var.name}-private-db-az1"
  }
}

# Public Subnets and NAT Gateway for AZ2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr_az2
  availability_zone       = var.az2
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-az2"
  }
}

resource "aws_eip" "nat_eip_az2" {
  #vpc = true
}

resource "aws_nat_gateway" "nat_gw_az2" {
  allocation_id = aws_eip.nat_eip_az2.id
  subnet_id     = aws_subnet.public_subnet_az2.id
  tags = {
    Name = "${var.name}-nat-gateway-az2"
  }
}

# Private Subnets for AZ2
resource "aws_subnet" "private_subnet_az2_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr_az2_1
  availability_zone = var.az2
  tags = {
    Name = "${var.name}-private-az2-1"
  }
}

resource "aws_subnet" "private_subnet_az2_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr_az2_2
  availability_zone = var.az2
  tags = {
    Name = "${var.name}-private-az2-2"
  }
}

resource "aws_subnet" "private_db_subnet_az2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_db_subnet_cidr_az2
  availability_zone = var.az2
  tags = {
    Name = "${var.name}-private-db-az2"
  }
}

# Route tables and associations
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_assoc_az2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt_az1" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_az1.id
  }
  tags = {
    Name = "${var.name}-private-rt-az1"
  }
}

resource "aws_route_table" "private_rt_az2" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_az2.id
  }
  tags = {
    Name = "${var.name}-private-rt-az2"
  }
}

resource "aws_route_table_association" "private_rt_assoc_az1_1" {
  subnet_id      = aws_subnet.private_subnet_az1_1.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "private_rt_assoc_az1_2" {
  subnet_id      = aws_subnet.private_subnet_az1_2.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "private_rt_assoc_az2_1" {
  subnet_id      = aws_subnet.private_subnet_az2_1.id
  route_table_id = aws_route_table.private_rt_az2.id
}

resource "aws_route_table_association" "private_rt_assoc_az2_2" {
  subnet_id      = aws_subnet.private_subnet_az2_2.id
  route_table_id = aws_route_table.private_rt_az2.id
}

# Database route table association
resource "aws_route_table_association" "private_db_rt_assoc_az1" {
  subnet_id      = aws_subnet.private_db_subnet_az1.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "private_db_rt_assoc_az2" {
  subnet_id      = aws_subnet.private_db_subnet_az2.id
  route_table_id = aws_route_table.private_rt_az2.id
}