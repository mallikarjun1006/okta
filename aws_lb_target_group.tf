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