provider "aws" {
  region = "us-west-1"
  shared_config_files = ["/Users/anhbamuoi/.aws/conf"]
  shared_credentials_files = ["/Users/anhbamuoi/.aws/credentials"]
}

resource "aws_eip" "lb" {
  domain = "vpc"
}

output "public_ip" {
  value = aws_eip.lb
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}