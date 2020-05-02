resource "aws_vpc" "bgerndt" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "bgerndt-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id            =  aws_vpc.bgerndt.id
  availability_zone = "us-east-2a"
  cidr_block        = "10.0.1.0/24"
  
  tags = {
    Name = "bgerndt-SUBNET"
  }
}