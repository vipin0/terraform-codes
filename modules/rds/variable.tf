##############  RDS subnet group #############
variable "subnet_group_name" {
  description = "Name of RDS subnet group."
  type        = string
  default     = "demo-subnet-group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet ids for RDS subnet group."
}

############## RDS instance ####################
variable "identifier" {
  type        = string
  description = "Identifier for RDS."
  default     = "my-demo-rds"
}
variable "allocated_storage" {
  type        = number
  description = "Stoage for RDS."
  default     = 10
}
variable "engine" {
  type        = string
  description = "Database Engine."
  default     = "mysql"
}
variable "engine_version" {
  type        = string
  description = "Database Engine Version."
  default     = "5.7"
}
variable "parameter_group_name" {
  type        = string
  description = "Database parameter group name."
  default     = "default.mysql5.7"
}
variable "db_instance_class" {
  type        = string
  description = "Instance type / size for RDS."
  default     = "db.t3.micro"
}

variable "multi_az" {
  type        = bool
  description = "Multi Az database"
  default     = false
}
variable "db_name" {
  description = "Database name"
  type        = string
  sensitive   = true
}
variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}
variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
############## RDS SG ####################
variable "security_group_name" {
  description = "Security group name for RDS."
  type        = string
  default     = "rds-security-group"
}

variable "vpc_id" {
  type        = string
  description = "VCP id for Security group."
}
variable "allowed_cidrs" {
  type        = list(string)
  description = "Allowed cidr block through RDS SG."
}
variable "from_port" {
  type        = number
  description = "from_port for DB."
  default     = 3306
}
variable "to_port" {
  type        = number
  description = "to_port for DB."
  default     = 3306
}
variable "protocol" {
  type        = string
  description = "protocol"
  default     = "tcp"
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
