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

resource "aws_network_interface" "primary_network_interface" {
  subnet_id   = "${aws_subnet.primary.id}"
  

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"  
  instance_type = "t2.micro"
  subnet_id="${aws_subnet.primary.id}"
	vpc_security_group_ids=["${aws_security_group.main.id}"]
	security_groups=["${aws_security_group.main.id}"]
	network_interface {
    network_interface_id = "${aws_network_interface.primary_network_interface.id}"
    device_index         = 0
  }
  tags = {
    Name = "HelloWorld"
  }
}