resource "aws_instance" "apache-server" {
  ami = "ami-0d2986f2e8c0f7d01" 
  instance_type = "t3a.nano"
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