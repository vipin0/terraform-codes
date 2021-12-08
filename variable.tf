variable "region" {
    description = "AWS region"
    type = string
    default = "us-east-2"
}
variable "credential_profile" {
    description = "Credential profile for AWS"
    type = string
    default = "default"
}

variable "instance_type" {
    description = "Intance type to run"
    type = string
    default = "t2.micro"
}
variable "key_name" {
     description = "key for the instance to SSH"
     type = string
     default = "vipin_ohio"
}
variable "instance_ingress_ports" {
    description = "ingress ports"
    type = list(string)
    default = [ "80"]
}

variable "availability_zones" {
  description = "List of AZs in which subnets have to create"
  type = list(string)
  default = [ "us-east-2a","us-east-2b"]
}

variable "instance_ssh_cidrs" {
  description = "IP to allow ssh connection to instances"
  type = list(string)
  default = [ "0.0.0.0/0"]
}
variable "vpc_cidr" {
    description = "VPC cidr block"
    type = string
    default = "10.0.0.0/16"
}
variable "owner" {
    description = "Owner Tag"
    type = string
    default = "example.com"
}
variable "tag_prefix" {
  description = "Tag Prefix"
  type = string
  default = "vipin"
}
variable "private_subnet_cidrs" {
  description = "CIDR for Private subnets"
  type = list(string)
  default = [ "10.0.1.0/24","10.0.2.0/24" ]
}
variable "public_subnet_cidrs" {
  description = "CIDR for public subnets"
  type = list(string)
  default = [ "10.0.3.0/24","10.0.4.0/24" ]
}
variable "instance_count" {
  description = "Number of instance to launch"
  type = number
  default = 2
}

# ---------rds config ------------------
variable "db_name" {
  description = "Database name"
  type = string
  default = "testdb"
}
variable "db_username" {
  description = "Database username"
  type = string
  default = "admin"
}
variable "db_password" {
  description = "Database password"
  type = string
  default = "admin123"
}