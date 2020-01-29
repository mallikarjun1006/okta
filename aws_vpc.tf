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



resource "aws_subnet" "primary" {
vpc_id     = "${aws_vpc.main.id}"
  availability_zone = data.aws_availability_zones.available.names[0]
tags = {
    Name = "primary"
  }
  # ...
}

resource "aws_subnet" "secondary" {
vpc_id     = "${aws_vpc.main.id}"
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