################# ALB ################
variable "name" {
  type        = string
  description = "Name of Application load balancer."
}
variable "subnets_ids" {
  description = "IDs of subnets for ALB."
  type        = list(string)
}

######################## Target group #######################
variable "target_group_name" {
  description = "target group name."
  type        = string
}
variable "vpc_id" {
  description = "VPC id for TG."
  type        = string
}

######################## ALB SG ################################
variable "security_group_name" {
  type        = string
  description = "ALB SG name."
  default     = "alb-security-group"
}

variable "health_check_path" {
  type        = string
  description = "health check path"
  default     = "/"
}
variable "health_check_port" {
  type        = number
  description = "health check port"
  default     = 80
}
variable "health_check_protocol" {
  type        = string
  description = "health check protocol"
  default     = "HTTP"
}
variable "health_check_timeout" {
  type        = number
  description = "health check timeout"
  default     = 5
}
variable "health_check_interval" {
  type        = number
  description = "health check interval"
  default     = 30
}
variable "health_check_matcher" {
  type        = string
  description = "health check matcher"
  default     = "200"
}
variable "healthy_threshold" {
  type        = number
  description = "healthy threshold"
  default     = 5
}
variable "unhealthy_threshold" {
  type        = number
  description = "unhealthy threshold"
  default     = 2
}


########################## Tags ###########################
variable "tags" {
  description = "Tag for the resources."
  type        = map(any)
  default = {
    ManagedBy = "Terraform"
  }
}
################### tag_prefix tag ##############
variable "tag_prefix" {
  type        = string
  description = "env tag_prefix for name tag"
  default     = ""
}
