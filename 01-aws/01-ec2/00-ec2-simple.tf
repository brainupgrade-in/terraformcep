resource "aws_instance" "tier-front" {
  ami           = "ami-0d2986f2e8c0f7d01"
  instance_type = "t3a.micro"

  tags = {
    Name = "MyFirstTerraformEC2"
  }
}