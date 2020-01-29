provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_security_groups" "test" {
  filter {
    name   = "group-name"
    values = ["*nodes*"]
  }

  filter {
    name   = "vpc-id"
    values = ["${aws_vpc.main.id}"]
  }
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids ="${data.aws_security_groups.test.id}"
  tags = {
    Name = "HelloWorld"
  }
}