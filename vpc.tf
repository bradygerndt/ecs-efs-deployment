resource "aws_vpc" "bgerndt" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "bgerndt-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.bgerndt.id
  tags = {
    Name      = "bgerndt-igw"
    Terraform = true
  }
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.bgerndt.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Terraform = true
  }
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.bgerndt.id
  availability_zone       = "us-east-2a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name   = "bgerndt-SUBNET"
    public = true
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.r.id
}
