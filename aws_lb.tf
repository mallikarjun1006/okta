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