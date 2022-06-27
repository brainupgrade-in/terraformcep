resource "aws_instance" "tier-front" {
  ami           = "ami-0c802847a7dd848c0"
  instance_type = "t3a.micro"

  tags = {
    Name = "terraform-ec2-rajesh"
  }
}