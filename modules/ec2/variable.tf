########################## launch template ##########

variable "associate_public_ip_address" {
  description = "Assign public IP address to instances"
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "Intance type to run"
  type        = string
}
variable "key_name" {
  description = "key for the instance to SSH"
  type        = string
}

variable "ami_id" {
  type        = string
  description = "AMI id for the instance."
}
variable "user_data" {
  type        = string
  description = "user-data for ec2."
  default     = ""
}

################### ASG Group ###########################
variable "asg_name" {
  type        = string
  description = "ASG name"
  default     = "vipinASG"
}

variable "max_size" {
  type        = number
  description = "ASG max size"
}
variable "min_size" {
  type        = number
  description = "ASG max size"
}
variable "desired_capacity" {
  type        = number
  description = "ASG desired_capacity"
}
variable "health_check_type" {
  type        = string
  description = " asg health check type"
  default     = "ELB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet ids in which instances are to be launched."
}

############################## ASG attachmant ##################
variable "alb_target_group_arn" {
  type        = string
  description = "alb target group arn"
}

############################# secrity group #################
variable "security_group_name" {
  type        = string
  description = "Name of security group for EC2 istance."
  default     = "instance-security-group"
}

variable "vpc_id" {
  type        = string
  description = "VPC id of security group"
}
variable "alb_security_group_id" {
  type        = string
  description = "ALB security group id"
}
variable "instance_ssh_cidrs" {
  description = "IP to allow ssh connection to instances"
  type        = list(string)
}
variable "instance_ingress_ports" {
  description = "ingress ports"
  type        = list(string)
  default     = []
}


########################## Tags ###########################
variable "tags" {
  description = "Tag for the resources."
  type        = map(any)
  default = {
    ManagedBy = "Terraform"
  }
}

################### prefix tag ##############
variable "prefix" {
  type        = string
  description = "env prefix for name tag"
  default     = ""
}

