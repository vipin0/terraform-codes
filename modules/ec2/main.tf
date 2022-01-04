# -------------------------------------------------------------#
#                     Security groups                          #
# -------------------------------------------------------------#
resource "aws_security_group" "instance_sg" {
  vpc_id = var.vpc_id
  name   = var.security_group_name
  # adding inbound rule for the given ports
  dynamic "ingress" {
    for_each = var.instance_ingress_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  # adding ssh inbound rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
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
  tags = var.tags
}

# -------------------------------------------------------------#
#                     Instances                                #
# -------------------------------------------------------------#
locals {
  subnets = var.subnets_ids
  length  = length(local.subnets)
  launch_subnets = [
    for i in range(var.instance_count) :
    local.subnets[i % local.length]
  ]
}
resource "aws_instance" "app_server" {
  count                       = var.instance_count
  subnet_id                   = local.launch_subnets[count.index]
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  associate_public_ip_address = var.associate_public_ip_address

  # connection {
  #   type        = "ssh"
  #   host        = self.public_dns
  #   user        = "ec2-user"
  #   private_key = file(var.private_key_path)
  # }
  # provisioner "file" {
  #   source = "~/Desktop/Assignments/index.php"
  #   # destination = "/var/www/html/index.php"
  #   destination = "/tmp/index.php"
  # }

  # provisioner "remote-exec" {

  #   inline = [
  #     "sudo mv /tmp/index.php /var/www/html"
  #   ]
  # }

  user_data = var.user_data

  tags = var.tags
}