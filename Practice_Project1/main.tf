provider "aws" {
    region = "us-east-1"
    # access_key = "AKIAZCLLKJQ6ULJSF4HO"
    # secret_key = "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"
}

variable "subnet_cidrBlock_value" {
  description = "Cider Block Value"
  default = "10.0.1.0/24" #
  //if value has not been passed it will ask for value (when default is not metioned)
  type = String #
}


resource "aws_vpc" "prnv-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}

output "owner-id" {
  value = aws_vpc.prnv-vpc.owner_id
}

# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.prnv-vpc.id
# }

# resource "aws_route_table" "prod-rout-table" {
#   vpc_id = aws_vpc.prnv-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   route {
#     ipv6_cidr_block        = "::/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   tags = {
#     Name = "prod-route"
#   }
# }

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.prnv-vpc.id
  cidr_block = var.subnet_cidrBlock_value  // 10.0.1.0/24
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "prod-subnet"
  }
}

# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.subnet-1.id
#   route_table_id = aws_route_table.prod-rout-table.id
# }

resource "aws_security_group" "allow_web" {
  name        = "allow_web_taffic"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.prnv-vpc.id

  ingress {
    description      = "HTTP"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

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
    Name = "allow_web"
  }
}

# resource "aws_network_interface" "web-server-nic" {
#   subnet_id       = aws_subnet.subnet-1.id
#   private_ips     = ["10.0.1.50"]
#   security_groups = [aws_security_group.allow_web.id]

# }

# resource "aws_eip" "one" {
#   vpc                       = true
#   network_interface         = aws_network_interface.web-server-nic.id
#   associate_with_private_ip = "10.0.1.50"
#   depends_on = [
#     aws_internet_gateway.gw
#   ]
# }

# resource "aws_instance" "prnv" {
#     ami = "ami-05fa00d4c63e32376"
#     instance_type = "t2.micro"
#     availability_zone = "us-east-1a"
#     key_name = "main-key"
#     # network_interface {
#     #   device_index = 0
#     #   network_interface_id = aws_network_interface.web-server-nic.id
#     # }
#     tags = {
#       Name = "pranav-machine"
#     }

#     user_data = <<-EOF
#                 #!/bin/bash
#                 echo pranav
#                 EOF
# }

