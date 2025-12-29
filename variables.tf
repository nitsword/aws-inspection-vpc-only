variable "region" {
  description = "AWS region"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# --- IPAM Configuration ---
variable "ipv4_ipam_pool_id" {
  description = "The ID of the IPv4 IPAM pool"
  type        = string
}

variable "ipv4_netmask_length" {
  description = "The netmask length for the primary VPC IPv4 CIDR (e.g., 24)"
  type        = number
  default     = 24
}

variable "ipv6_ipam_pool_id" {
  description = "The ID of the IPv6 IPAM pool (null to use Amazon default)"
  type        = string
  default     = null
}


variable "private_firewall_ipv6_cidrs" {
  description = "IPv6 CIDRs for private firewall subnets"
  type        = list(string)
  default     = []
}


variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "application" { type = string }
variable "environment" { type = string }
variable "env" { type = string }

variable "base_tags" {
  type    = map(string)
  default = { "Created by" = "Cloud Network Team" }
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID"
  type        = string
}

variable "secondary_cidr_blocks" {
  type        = list(string)
  description = "List of secondary IPv4 CIDR blocks passed from dev.tfvars"
  default     = []
}

variable "bucket_name" {
  description = "Name of the s3 bucket"
  type        = string
  default     = ""
}

variable "vpc_netmask" {
  description = "The netmask length for the VPC IPv4 CIDR"
  type        = number
  # default     = 24 
}