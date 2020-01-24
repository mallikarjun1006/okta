resource "aws_ami_from_instance" "CHTest_1a_Linux_VM" {
  name               = "terraform-example"
  source_instance_id = "i-097d721a5e365e590"
}
