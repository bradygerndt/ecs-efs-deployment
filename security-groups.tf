resource "aws_security_group" "allow_factorio" {
  name        = "factorio-service"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.bgerndt.id

  ingress {
    protocol    = "6"
    from_port   = 80
    to_port     = 8000
    cidr_blocks = [aws_vpc.bgerndt.cidr_block]
  }
  
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_efs_mount" {
  name = "factorio-service-efs"
  description  = "Allow access to efs from factorio services"
  vpc_id = aws_vpc.bgerndt.id

  ingress {
    protocol = "6"
    from_port = 2049
    to_port = 2049
    cidr_blocks = [aws_vpc.bgerndt.cidr_block]
    security_groups = [aws_security_group.allow_factorio.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [aws_security_group.allow_factorio.id]
  }
}