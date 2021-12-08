# -------------------------------------------------------------#
#                     Security groups                          #
# -------------------------------------------------------------#
resource "aws_security_group" "instance_sg" {
    vpc_id = aws_vpc.my_vpc.id
    name = "vipin-instance-SG"
    # adding inbound rule for the given ports
    dynamic "ingress" {
      for_each = var.instance_ingress_ports
      iterator = port
      content {
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
      }
    }
    # adding ssh inbound rule
    ingress{
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = var.instance_ssh_cidrs
    }
    # outbound rules
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.tag_prefix}-Intance-SG"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "alb_sg" {
    name = "vipin-alb-SG"
    vpc_id = aws_vpc.my_vpc.id
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.tag_prefix}-alb-SG"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "db_sg" {
    name = "vipin-db-SG"
    vpc_id = aws_vpc.my_vpc.id
    ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = toset(aws_subnet.public_subnets[*].cidr_block)
    }
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.tag_prefix}-db-SG"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}
