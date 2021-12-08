# -------------------------------------------------------------#
#                    RDS subnet group                          #
# -------------------------------------------------------------#

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "vipin_subnet_group"
  subnet_ids = aws_subnet.public_subnets[*].id

  tags = {
    Name = "${var.tag_prefix}-RDS-subnet-group"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}
# -------------------------------------------------------------#
#                    RDS Instances                             #
# -------------------------------------------------------------#
resource "aws_db_instance" "my_rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name =  aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot  = true

  tags = {
    Name = "${var.tag_prefix}-RDS"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}