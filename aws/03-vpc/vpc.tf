
resource "aws_vpc" "rajesh-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
    tags = {
    Name = "rajesh-vpc"
  }
}
resource "aws_internet_gateway" "rajesh-vpc-igw" {
  vpc_id = aws_vpc.rajesh-vpc.id
  tags ={
    Name = "rajesh-vpc-igw"
  }
}
resource "aws_route_table" "rajesh-vpc-rt-pb" {
  
  vpc_id = aws_vpc.rajesh-vpc.id
  route{
      cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rajesh-vpc-igw.id
  }
  tags ={
    Name = "rajesh-vpc-rt-pb"
  }
}


