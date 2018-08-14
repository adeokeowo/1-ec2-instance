data "aws_ami" "amazonlinux" {
  most_recent = true

  filter {
    name   = "ImageId"
    values = ["ami-b8b45ddf"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}