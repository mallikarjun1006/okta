resource "aws_eip" "lb" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "lb" {
  instance = "${aws_instance.web1.id}"
  vpc      = true
}