output "alb_dns_name" {
    value = aws_lb.my_alb.dns_name
}
output "instance_public_ips" {
    value = [for instance in aws_instance.app_server : instance.public_ip]
}
# output "public_subets" {
#     value = aws_subnet.public_subnets[*]
# }

output "rds_endpoint" {
    value = aws_db_instance.my_rds.endpoint
}