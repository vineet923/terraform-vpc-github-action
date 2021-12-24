

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

resource "aws_s3_bucket" "vkbucket" {

  bucket = "vkbucket-lab"
  acl    = "private"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

}
