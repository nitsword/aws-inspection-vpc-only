variable "private_tg_subnet_ids" {
  description = "List of private_tg subnet IDs (one per AZ, for TGW attachment)"
  type        = list(string)
}

variable "private_firewall_subnet_ids" {
  description = "List of private_firewall subnet IDs (all subnets for firewall)"
  type        = list(string)
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "firewall_subnet_ids" {
  description = "List of firewall subnet IDs"
  type        = list(string)
  default = []
}


variable "tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default     = {}
}

variable "tgw_subnet_ids" {
  description = "AZ-ordered list of Transit Gateway subnet IDs."
  type        = list(string)
  default = []
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID used by firewall subnet route tables."
  type        = string
}

variable "tgw_attachment_id" {
  description = "The ID of the TGW attachment to ensure ordering"
  type        = string
  default     = ""
}



variable "enable_ipv6" {
  description = "Enable IPv6 routes in TGW subnet route tables."
  type        = bool
  default     = true
}


# subnet objects AZ 
variable "private_tg_subnets_full" {
  description = "The full subnet objects for private_tg"
}

variable "application" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }
variable "env" { type = string }