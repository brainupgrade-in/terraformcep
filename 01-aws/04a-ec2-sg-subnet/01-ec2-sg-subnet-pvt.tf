resource "aws_instance" "rajesh-vpc-ec2" {
  count                         = 1
  ami                           = "ami-0c802847a7dd848c0"
  instance_type                 = "t3a.micro"
  key_name                      = "scbcepb3"
  vpc_security_group_ids        = [aws_security_group.rajesh-vpc-sg.id]
  subnet_id                     = aws_subnet.rajesh-vpc-pvt-1a.id
tags = {
    Name = "rajesh-vpc_${count.index}"
  }
}