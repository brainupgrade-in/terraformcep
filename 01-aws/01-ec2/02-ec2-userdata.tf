resource "aws_instance" "apache-server" {
  ami = "ami-0c802847a7dd848c0" 
  instance_type = "t3a.nano"
  tags={
    Name = "terraform-httpd-rajesh"
  }
  user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
  EOF
}