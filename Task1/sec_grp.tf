resource "aws_security_group" "elb-sg" {
  name        = "elb-sg"
  description = "Allow web inbound traffic"
  
  ingress {
    description      = "HTTPs"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb-sg"
  }
}

# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "sub1" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
#   tags = {
#     Name = "sub1"
#   }
# }

# resource "aws_subnet" "sub2" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.10.0/24"
#   availability_zone = "us-east-1b"
#   tags = {
#     Name = "sub2"
#   }
# }