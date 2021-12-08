# -------------------------------------------------------------#
#                     Instances                                #
# -------------------------------------------------------------#

resource "aws_instance" "app_server" {
  count = 2
  # for_each = toset(aws_subnet.public_subnets[*].id)
  subnet_id = aws_subnet.public_subnets[count.index].id
  ami           = data.aws_ami.latest_amazon_linux_ami.id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  # associate_public_ip_address = true
  user_data = <<EOF
                #! /bin/bash
                sudo yum update
                sudo yum install -y httpd
                sudo systemctl start httpd
                sudo systemctl enable httpd
                sudo echo "<h1>Deployed via Terraform</h1>" > /var/www/html/index.html
	            EOF

  tags = {
    Name = "${var.tag_prefix}-app-server"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}