provider "aws" {
 region = "eu-west-2"
 version = "~> 1.15.77"
}

resource "aws_instance" "my-test-instance" {
  ami             = "ami-b8b45ddf"
  instance_type   = "t2.micro"

  tags {
    Name = "test-instance"
  }
}