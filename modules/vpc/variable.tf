###################### VPC #########################
variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
}
variable "enable_dns_hostnames" {
  description = "Enable dns hostnames."
  default     = true
  type        = bool
}
variable "enable_dns_support" {
  description = "Enable dns support."
  default     = true
  type        = bool
}
variable "azs" {
  type        = list(string)
  description = "Availability zones"
}
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "cidr block of public subnets."

}
variable "private_subnet_cidrs" {
  type        = list(string)
  description = "cidr of private subnets."
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

