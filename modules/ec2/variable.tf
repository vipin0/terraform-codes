########################## ec2 instance configuration ##########

variable "associate_public_ip_address" {
  description = "Assign public IP address to instances"
  type        = bool
  default     = true
}

variable "instance_count" {
  description = "Number of instance to launch."
  type        = number
  default     = 1
}

variable "subnets_ids" {
  type        = list(string)
  description = "subnet ids in which instances are to be launched."
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

############################# secrity group #################
variable "security_group_name" {
  type        = string
  description = "Name of security group for EC2 istance."
  default     = "instance-security-group-tf"
}

variable "vpc_id" {
  type        = string
  description = "VPC id of security group"
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

################ for connection ########################
variable "private_key_path" {
  description = "Path of private key"
  type        = string
  sensitive   = true
}

########################## Tags ###########################
variable "tags" {
  description = "Tag for the resources."
  type        = map(any)
  default = {
    ManagedBy = "Terraform"
  }
}

variable "user_data" {
  type        = string
  description = "user-data for ec2."
  default     = ""
}