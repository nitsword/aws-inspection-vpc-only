variable "ipv4_ipam_pool_id" {
  description = "The ID of the IPAM pool for IPv4"
  type        = string
}

variable "ipv6_ipam_pool_id" {
  description = "The ID of the IPAM pool for IPv6"
  type        = string
  default     = null
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "vpc_primary_cidr"      { type = string }
variable "vpc_secondary_cidr"    { type = string }
variable "vpc_primary_ipv6_cidr" { type = string }
#variable "vpc_secondary_ipv6_cidr" { type = string }

variable "application" { type = string }
variable "environment" { type = string }
variable "env"         { type = string }
variable "region"      { type = string }
variable "base_tags"   { type = map(string) }