resource "aws_security_group" "db-sg" {
  vpc_id      = data.aws_vpc.main.id
ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "Allow traffic to DB"
    cidr_blocks = [data.aws_vpc.main.cidr_block]
  }
ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    description = "Allow traffic to DB"
    cidr_blocks = [data.aws_vpc.main.cidr_block]
  }
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}