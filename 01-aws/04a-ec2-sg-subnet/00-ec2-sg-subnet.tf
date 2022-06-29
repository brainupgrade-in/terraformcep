resource "aws_instance" "rajesh-vpc-ec2" {
  count                         = 2
  ami                           = "ami-0c802847a7dd848c0"
  instance_type                 = "t3a.micro"
  key_name                      = "scbcepb3u"
  vpc_security_group_ids        = [aws_security_group.rajesh-vpc-sg.id]
  subnet_id                     = aws_subnet.rajesh-vpc-pb-1a.id
  associate_public_ip_address   = "true"
tags = {
    Name = "rajesh-vpc_${count.index}"
  }
}