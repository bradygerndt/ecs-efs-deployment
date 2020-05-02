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
}