resource "aws_eip" "eip1" {
	name="instance1 eip"
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "eip2" {
name="instance1 eip"
  instance = "${aws_instance.web1.id}"
  vpc      = true
}