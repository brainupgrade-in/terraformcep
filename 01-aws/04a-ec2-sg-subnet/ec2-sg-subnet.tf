resource "aws_instance" "rajesh-vpc-ec2" {
  count                         = 3
  ami                           = "ami-0d2986f2e8c0f7d01"
  instance_type                 = "t3a.micro"
  key_name                      = "cirrus"
  vpc_security_group_ids        = [aws_security_group.rajesh-vpc-sg.id]
  subnet_id                     = aws_subnet.rajesh-vpc-pb-1a.id
  associate_public_ip_address   = "true"
tags = {
    Name = "rajesh-vpc_${count.index}"
  }
}