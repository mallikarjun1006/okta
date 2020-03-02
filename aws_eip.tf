resource "aws_eip" "eip1" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "eip2" {
  instance = "${aws_instance.web1.id}"
  vpc      = true
}