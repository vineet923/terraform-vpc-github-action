resource "aws_vpc" "test-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "vktest-vpc"
  }
}

resource "aws_subnet" "test-sub-pub-1" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "test-sub-pub-1"
  }
}

resource "aws_subnet" "test-sub-priv-1" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE1
  tags = {
    Name = "test-sub-priv-1"
  }
}


resource "aws_internet_gateway" "test-IGW" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "test-IGW"
  }
}

resource "aws_route_table" "test-pub-RT" {
  vpc_id = aws_vpc.test-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-IGW.id
  }
  tags = {
    Name = "test-pub-RT"
  }
}

resource "aws_route_table_association" "test-sub-pub-1-a" {
  subnet_id      = aws_subnet.test-sub-pub-1.id
  route_table_id = aws_route_table.test-pub-RT.id
}

