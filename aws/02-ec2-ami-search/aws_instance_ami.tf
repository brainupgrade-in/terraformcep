
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.micro"

  tags = {
    Name = "terraform"
  }
}
