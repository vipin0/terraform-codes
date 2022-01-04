output "instance_ips" {
  description = "Instances public ips"
  value = aws_instance.app_server[*].public_ip
}
output "instance_ids" {
  description = "Instance ids"
  value = aws_instance.app_server[*].id
}
output "instance_count" {
  description = "Number of instances launched"
  value = length(aws_instance.app_server[*].id)
}