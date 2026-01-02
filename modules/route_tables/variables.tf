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


variable "tg_subnet_map" {
  type        = map(string)
  description = "Map of AZ to Subnet ID for TGW subnets"
}

variable "fw_subnet_map" {
  type        = map(string)
  description = "Map of AZ to Subnet ID for Firewall subnets"
}

variable "application" { type = string }
variable "environment" { type = string }
variable "region" { type = string }
variable "base_tags" { type = map(string) }
variable "env" { type = string }