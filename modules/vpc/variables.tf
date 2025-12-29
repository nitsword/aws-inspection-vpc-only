variable "ipv4_ipam_pool_id" {
  description = "The ID of the IPAM pool for IPv4"
  type        = string
}

variable "ipv4_netmask_length" {
  description = "Netmask length for the primary IPv4 CIDR"
  type        = number
  default     = 24
}

variable "ipv6_ipam_pool_id" {
  description = "The ID of the IPAM pool for IPv6"
  type        = string
  default     = null
}

variable "secondary_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "vpc_netmask" {
  description = "The netmask length for the primary IPv4 CIDR"
  type        = number
}

variable "application" { type = string }
variable "environment" { type = string }
variable "env"         { type = string }
variable "region"      { type = string }
variable "base_tags"   { type = map(string) }