output "dns_name" {
  value = aws_lb.my_alb.dns_name
  description = "Application load balancer dns name."
}