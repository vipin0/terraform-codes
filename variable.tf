########################## provider configuration #######################
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}
variable "credential_profile" {
  description = "Credential profile for AWS"
  type        = string
  default     = "default"
}
# variable "key_name" {
#   description = "key for the instance to SSH"
#   type        = string
#   default     = "vipin_ohio"
# }
####################### VPC ########################
variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

# ---------rds config ------------------
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "testdb"
  sensitive   = true
}
variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
  sensitive   = true
}
variable "db_password" {
  description = "Database password"
  type        = string
  default     = "admin123"
  sensitive   = true
}

###################### Tags ################
variable "additonal_tags" {
  type        = map(any)
  description = "Addtional Tags for resources."
  default = {
    "ManagedBy" = "Terraform"
  }
}