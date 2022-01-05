output "dns_name" {
  value       = aws_lb.my_alb.dns_name
  description = "Application load balancer dns name."
}

output "aws_lb_target_group_arn" {
  value       = aws_lb_target_group.my_tg.arn
  description = "Target group ARN"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb_sg.id
  description = "ALB security group id"
}