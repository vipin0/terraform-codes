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

####################### VPC ########################
variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
  default     = "10.0.0.0/16"
}
variable "azs" {
  type = list(string)
  description = "List of availability zones."
}
variable "public_subnet_cidrs" {
  type = list(string)
  description = "cidr blocks of public subnets."
}
variable "private_subnet_cidrs" {
  type = list(string)
  description = "cidr blocks of private subnets."
}

##################### ec2 module ######################
variable "key_name" {
  description = "key for the instance to SSH"
  type        = string
}

variable "instance_type" {
  type = string
  description = "Instance Type to launch"
}
variable "min_size" {
  type = string
  description = "Min number of instanes for ASG"
}
variable "max_size" {
  type = string
  description = "Max number of instanes for ASG"
}
variable "desired_capacity" {
  type = string
  description = "Desired number of instanes for ASG"
}

variable "associate_public_ip_address" {
  type = string
  description = "associate public ip address to the instances"
}
variable "instance_ssh_cidrs" {
  type = list(string)
  description = "instance ssh cidrs"
}
variable "instance_ingress_ports" {
  type = list(string)
  description = "instance ingress ports"
}
variable "user_data" {
  type = string
  description = "User data for instance"
}

############# ALB module ##############
variable "name" {
  type = string
  description = "ALB name"
}
variable "target_group_name" {
  type = string
  description = "target group name"
}
# ---------rds config ------------------
variable "subnet_group_name" {
  type = string
  description = "rds subnet group name"
}
variable "identifier" {
  type = string
  description = "database identidier"
}
variable "db_instance_class" {
  type = string
  description = "db instance class"
}
variable "security_group_name" {
  type = string
  description = "db instance class"
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

###################### Tags ################
variable "additonal_tags" {
  type        = map(any)
  description = "Addtional Tags for resources."
  default = {
    "ManagedBy" = "Terraform"
  }
}

variable "tag_prefix" {
  type = string
  description = "Prefix for name tag of the resources."
  default = ""
}