resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}

# e.g. Create subnets in the first two available availability zones




resource "aws_subnet" "primary" {
vpc_id     = "${aws_vpc.main.id}"
cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
tags = {
    Name = "primary"
  }
  # ...
}

resource "aws_subnet" "secondary" {
vpc_id     = "${aws_vpc.main.id}"
cidr_block = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
tags = {
    Name = "secondary"
  }
  # ...
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "main"
  }
}

resource "aws_security_group" "main" {
  name        = "main"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"
ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
    
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]    
  }
  

  tags = {
    Name = "main"
  }
}

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





resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id="${aws_subnet.primary.id}"
	vpc_security_group_ids=["${aws_security_group.main.id}"]
  tags = {
    Name = "HelloWorld"
  }
}