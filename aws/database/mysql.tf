## DB Subent Group
resource "aws_db_subnet_group" "rajesh-vpc-db-subnet-grp" {
  name       = "rajesh-vpc-db-subnet-grp"
  subnet_ids = [aws_subnet.rajesh-vpc-pvt-1a.id, aws_subnet.rajesh-vpc-pvt-1b.id]
tags = {
    Name = "rajesh-vpc-db-subnet-grp"
  }
}
## DB instance
resource "aws_db_instance" "rajesh-vpc-db-mysql" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t2.micro"
  name                    = "smartbankapp"
  identifier              = "rajesh-vpc"
  username                = "mysql"
  password                = "mysqlsba"
  parameter_group_name    = "default.mysql8.0"
  db_subnet_group_name    = aws_db_subnet_group.rajesh-vpc-db-subnet-grp.name
  vpc_security_group_ids  = [aws_security_group.rajesh-vpc-sg-db.id]
  skip_final_snapshot     = "true"
}