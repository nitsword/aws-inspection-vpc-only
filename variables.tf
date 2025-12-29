variable "region" {
  description = "AWS region"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_tg_cidrs" {
  description = "CIDRs for private TG subnets"
  type        = list(string)
  default     = []
}

variable "private_firewall_cidrs" {
  description = "CIDRs for private firewall subnets"
  type        = list(string)
  default     = []
}

# variable "private_tg_ipv6_cidrs" {
#   description = "IPv6 CIDRs for private TG subnets"
#   type        = list(string)
#   default     = []
# }

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
}

variable "bucket_name" {
  description = "Name of the s3 bucket"
  type        = string
  default     = ""
}
