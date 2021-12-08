# -------------------------------------------------------------#
#                     ALB                                      #
# -------------------------------------------------------------#

resource "aws_lb" "my_alb" {
  name               = "vipin-alb-08122021"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnets[*].id
  enable_deletion_protection = false
  tags = {
    Name = "${var.tag_prefix}-alb"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}
# -------------------------------------------------------------#
#                     Target Groups                            #
# -------------------------------------------------------------#

resource "aws_lb_target_group" "my_tg" {
  name = "vipin-tf-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}
# -------------------------------------------------------------#
#               Attach instance and alb to TG                  #
# -------------------------------------------------------------#

resource "aws_lb_target_group_attachment" "attach_tg" {
  count = var.instance_count
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = aws_instance.app_server[count.index].id
  port             = 80
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