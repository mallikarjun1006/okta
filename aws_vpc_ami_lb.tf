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

resource "aws_security_group" "main1" {
  name        = "main1"
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
    Name = "main1"
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
	security_groups=["${aws_security_group.main.id}"]	
	key_name="${aws_key_pair.deployer.key_name}"
  
  tags = {
    Name = "instance1"
  }
}

resource "aws_instance" "web1" {
  ami           = "${data.aws_ami.ubuntu.id}"  
  instance_type = "t2.micro"
  subnet_id="${aws_subnet.secondary.id}"
	vpc_security_group_ids=["${aws_security_group.main1.id}"]
	security_groups=["${aws_security_group.main1.id}"]
key_name="${aws_key_pair.deployer.key_name}"	
  tags = {
    Name = "instance2"
  }
}

resource "aws_security_group" "main_lb_sg" {
  name        = "main_lb_sg"
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
    Name = "main_lb_sg"
  }
}

resource "aws_lb" "mainlb" {
  name               = "mainlb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.main_lb_sg.id}"]
  subnets            = ["${aws_subnet.primary.id}","${aws_subnet.secondary.id}"]

  enable_deletion_protection = true

  

  tags = {
    Environment = "mainlb"
  }
}

resource "aws_lb_target_group" "testgroup" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.mainlb.arn}"
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.testgroup.arn}"
  }
}
