# -------------------------------------------------------------#
#                    RDS subnet group                          #
# -------------------------------------------------------------#

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  tags = merge(
    var.tags,
    {
      "Name" : "${var.prefix}DatabaseSubnetGroup"
    }
  )
}
# -------------------------------------------------------------#
#                    RDS Instances                             #
# -------------------------------------------------------------#
resource "aws_db_instance" "my_rds" {
  identifier             = var.identifier
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.db_instance_class
  multi_az               = var.multi_az
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.parameter_group_name
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true

  tags = merge(
    var.tags,
    {
      "Name" : "${var.prefix}RDSDatabase"
    }
  )
}

#################### RDS SG ##########################
resource "aws_security_group" "db_sg" {
  name   = var.security_group_name
  vpc_id = var.vpc_id
  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = var.allowed_cidrs
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge(
    var.tags,
    {
      "Name" : "${var.prefix}DatabaseSecurityGroup"
    }
  )
}
