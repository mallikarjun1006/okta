provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*""]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["402834009890"] # Canonical
}