module "provider"{
    source = "../../01-aws/00-providers"
    region = var.region
}

variable "region"{
    default = "ap-southeast-1"
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = "my-ec2-cluster"
  instance_count = 1

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3a.nano"
  vpc_id = aws_default_vpc.default_vpc.id
  subnet_id = aws_default_subnet.default_subnet.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
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
resource "aws_default_vpc" "default_vpc" {
}
resource "aws_default_subnet" "default_subnet" {
  vpc_id = aws_default_vpc.default_vpc.id
}