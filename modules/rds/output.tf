output "rds_endpoint" {
  value = aws_db_instance.my_rds.address
  description = "database address"
}
output "rds_port" {
  value = aws_db_instance.my_rds.port
  description = "database port"
}
