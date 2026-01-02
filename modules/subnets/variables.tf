variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}


variable "tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default     = {}
}

variable "tgw_subnet_cidrs" { type = map(string) }
variable "fw_subnet_cidrs"  { type = map(string) }

# IPv6 CIDRs from VPC
variable "vpc_ipv6_cidr_primary" { 
  type    = string 
  default = "" 
}

variable "application" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }
variable "env" { type = string }