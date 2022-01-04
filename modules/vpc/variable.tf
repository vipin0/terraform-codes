###################### VPC #########################
variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
}

variable "newbits" {
  description = "newbits for subnets, default is 8"
  type        = number
  default     = 8
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
variable "public_subnet_count" {
  type        = number
  description = "Number of public subnets."
  default     = 1
}
variable "private_subnet_count" {
  type        = number
  description = "Number of private subnets."
  default     = 1
}

########################## Tags ###########################
variable "tags" {
  description = "Tag for the resources."
  type        = map(any)
  default = {
    ManagedBy = "Terraform"
  }
}
