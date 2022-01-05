# -------------------------------------------------------------#
#                     ALB                                      #
# -------------------------------------------------------------#

resource "aws_lb" "my_alb" {
  name                       = var.name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = var.subnets_ids
  enable_deletion_protection = false
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}LoadBalancer"
    }
  )
}
# -------------------------------------------------------------#
#                     Target Groups                            #
# -------------------------------------------------------------#

resource "aws_lb_target_group" "my_tg" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  # health_check {
  #   path                = "/index.html"
  #   port                = 80
  #   healthy_threshold   = 3
  #   unhealthy_threshold = 2
  #   protocol            = "HTTP"
  #   timeout             = 10
  #   interval            = 20
  #   matcher             = "200" # has to be HTTP 200 or fails
  # }
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}LoadBalancerTargetGroup"
    }
  )
}

# -------------------------------------------------------------#
#                       ALB Listener                           #
# -------------------------------------------------------------#
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my_tg.arn
    type             = "forward"
  }
}
# -------------------------------------------------------------#
#                     ALB listener rule                        #
# -------------------------------------------------------------#

resource "aws_alb_listener_rule" "alb_listener_rule" {
  depends_on = [
    aws_lb_target_group.my_tg,
  ]
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

###################### ALB SG ###################
resource "aws_security_group" "alb_sg" {
  name   = var.security_group_name
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # ingress {
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
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
      "Name" : "${var.tag_prefix}LoadBalancerSecurityGroup"
    }
  )
}
