resource "aws_instance" "apache-server" {
subnet_id = aws_subnet.rajesh-vpc-pb-1b.id
  vpc_security_group_ids = [aws_security_group.rajesh-vpc-sg.id]
  ami = "ami-0c802847a7dd848c0" 
  instance_type = "t3a.nano"
  key_name = data.aws_key_pair.keypair.key_name
  tags={
    Name = "apache-server"
  }
  user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
  EOF
}