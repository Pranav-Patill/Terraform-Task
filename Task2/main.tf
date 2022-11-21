provider "aws" {
    region = "us-east-1"
    profile = "default"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_instance" "inst-1" {
    ami = "ami-05fa00d4c63e32376"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    key_name = "main-key"
    vpc_security_group_ids = [ "${aws_security_group.inst-sg-1.id}" ]
    
    tags = {
      Name = "machine-1"
    }
}
resource "aws_instance" "inst-2" {
    ami = "ami-05fa00d4c63e32376"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    key_name = "main-key"
    vpc_security_group_ids = [ "${aws_security_group.inst-sg-2.id}" ]
    
    tags = {
      Name = "machine-2"
    }
}

resource "aws_security_group" "inst-sg-1" {
  name        = "sg_con_1"
  description = "Allow web inbound traffic"

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
    Name = "Sg_con_1"
  }
}

resource "aws_security_group" "inst-sg-2" {
  name        = "sg_con_2"
  description = "Allow web inbound traffic"

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
    Name = "Sg_con_2"
  }
}

resource "aws_security_group_rule" "inst-sgr1" {
  type                     = "ingress"
  description              = "instance1"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = "${aws_security_group.inst-sg-2.id}"
  security_group_id        = "${aws_security_group.inst-sg-1.id}"
}

resource "aws_security_group_rule" "inst-sgr2" {
  type                     = "ingress"
  description              = "instance2"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = "${aws_security_group.inst-sg-1.id}"
  security_group_id        = "${aws_security_group.inst-sg-2.id}"
  
}
