resource "aws_instance" "my-test-instance" {
  ami             = "${data.aws_ami.amazonlinux.id}"
  instance_type   = "t2.micro"

  tags {
    Name = "test-instance"
  }
}