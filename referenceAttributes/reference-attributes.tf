provider "aws" {
  region = "us-west-1"
}

resource "aws_eip" "lb" {
  domain = "vpc"
}