output "alb_dns_name" {
  description = "Dns name of the load balancer."
  value       = module.alb.dns_name
}
# output "instance_public_ips" {
#     value = [for instance in aws_instance.app_server : instance.public_ip]
# }
# output "public_subets" {
#     value = aws_subnet.public_subnets[*]
# }
/*
output "rds_endpoint" {
  description = "RDS endpoint address."
  value = module.rds.rds_endpoint
}
*/

/*
output "public_subnets_cidrs" {
  description = "cidr blocks of the public subnets."
  value       = module.vpc.public_subnet_cidrs
}
output "private_subnets_cidrs" {
  description = "cidr blocks of the private subnets."
  value       = module.vpc.private_subnet_cidrs
}

*/