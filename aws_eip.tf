resource "aws_eip" "eip1" {
	
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "eip2" {

  instance = "${aws_instance.web1.id}"
  vpc      = true
}

resource "aws_key_pair" "ec2user" {
  key_name   = "ec2user"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAxVnhMfcugV+t2IeznoyCRk9AqrUo+NPivbLU2/iMwgQmlTQ8fQLxDwpCtUn0tcxI/ur6drWmnX7akWJyxsCbDnHfKL07uI54Z+w+iJkJ/bboixSIys1tKZn3mRfdoSl4RaWSAkjjOI5vcM4Un7OH8WKeRvtQgFbOSA2gJP/+Yia9fIPynCKXXG9sdhc90TTKKPGr2b8WRr9JVjK50HLRvZfh8epK8r50tnxuzXUD6Y5WjhJhtQNKDV8ow+B9r4QNcVCVbbwnDwRPwgaYdBxT/iZTvYxSUZLaM6clmyXoVRxK4vCigBoZniyvo/OTqIUdqw1HKzrIjfSsu0TwzREpdw== rsa-key-20200303"
}