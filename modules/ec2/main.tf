# -------------------------------------------------------------#
#                     Security groups                          #
# -------------------------------------------------------------#
resource "aws_security_group" "instance_sg" {
  description = "Allow HTTP traffic from ALb security group"
  vpc_id      = var.vpc_id
  name        = var.security_group_name
  # adding inbound rule for the given ports
  # dynamic "ingress" {
  #   for_each = var.instance_ingress_ports
  #   iterator = port
  #   content {
  #     from_port   = port.value
  #     to_port     = port.value
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
  # }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
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
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}InstanceSecurityGroup"
    }
  )
}

################## launch configuration #####################
resource "aws_launch_configuration" "as_conf" {
  name            = "CustomLaunchConfig"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  user_data       = base64encode(var.user_data)
  security_groups = [aws_security_group.instance_sg.id]
  key_name        = var.key_name

  lifecycle {
    create_before_destroy = true
  }
}

###################### launch template #########################

resource "aws_launch_template" "launch_template" {
  name = "CustomLaunchTemplate"

  disable_api_termination = false

  image_id = var.ami_id

  instance_initiated_shutdown_behavior = "stop"

  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.tags,
      {
        "Name" : "${var.tag_prefix}ASGInstance"
      }
    )
  }

  user_data = base64encode(var.user_data)

  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}LaunchTemplate"
    }
  )


}

########################## asg group #######################
resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  target_group_arns         = [var.alb_target_group_arn]
  # launch_configuration      = aws_launch_configuration.as_conf.name
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.subnet_ids

  # timeouts {
  #   delete = "10m"
  # }

  tag {
    key                 = "Name"
    value               = "${var.tag_prefix}appserver"
    propagate_at_launch = true
  }
  dynamic "tag" {
    for_each = var.tags
    iterator = tag
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

