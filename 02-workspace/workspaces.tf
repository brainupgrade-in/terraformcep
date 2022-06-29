terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = var.region
}

variable "region"{
  default = "ap-southeast-1"
}
variable "environment" {
  type = string
  description = "(optional) describe your variable"
  default = "dev"
}
resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.micro"
  tags = {
    Name = "terraform-workspace-${var.environment}"
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
