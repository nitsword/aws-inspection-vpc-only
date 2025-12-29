# Data source to fetch the VPC CIDR assigned by IPAM
data "aws_vpc" "selected" {
  id = var.vpc_id
}

## Subnet Derivation Locals
locals {
  # We use the variable directly to ensure the conditional logic is clean
  vpc_ipv4_cidr = data.aws_vpc.selected.cidr_block
  vpc_ipv6_cidr         = var.vpc_ipv6_cidr
  new_subnet_bits       = 8
  
  # Offsets for IPv4 subnetting to prevent overlap
  tg_ipv4_offset        = 0
  fw_ipv4_offset        = 4
  
  # Offset for IPv6
  firewall_index_offset = 100 
}

## Private Transit Gateway (TG) Subnets
resource "aws_subnet" "private_tg" {
  count                   = length(var.azs)
  vpc_id                  = var.vpc_id
  
  # IPv4 calculation
  #cidr_block              = cidrsubnet(data.aws_vpc.selected.cidr_block, 4, count.index + local.tg_ipv4_offset)
  
  availability_zone       = var.azs[count.index]
  cidr_block = local.vpc_ipv4_cidr != "" ? cidrsubnet(local.vpc_ipv4_cidr, 4, count.index) : null
  map_public_ip_on_launch = false

  # FIX: Only attempt cidrsubnet if IPv6 CIDR is not empty
  ipv6_cidr_block = local.vpc_ipv6_cidr != "" ? cidrsubnet(
    local.vpc_ipv6_cidr,
    local.new_subnet_bits,
    count.index
  ) : null

  # Only assign if we actually have an IPv6 block
  assign_ipv6_address_on_creation = local.vpc_ipv6_cidr != "" ? true : false

  tags = merge(
    {
      Name            = "${var.application}-${var.env}-pvt-subnet-tg-${var.azs[count.index]}"
      "Resource Type" = "pvt-subnet-tg"
      "Environment"   = var.environment
      "Application"   = var.application
      "Created by"    = "Cloud Network Team"
      "Region"        = var.region
    },
    var.base_tags
  )
}

## Private Network Firewall Subnets
resource "aws_subnet" "private_firewall" {
  count                   = length(var.azs)
  vpc_id                  = var.vpc_id
  
  # IPv4 calculation
  #cidr_block              = cidrsubnet(data.aws_vpc.selected.cidr_block, 4, count.index + local.fw_ipv4_offset)
  
  availability_zone       = var.azs[count.index]
  cidr_block = local.vpc_ipv4_cidr != "" ? cidrsubnet(local.vpc_ipv4_cidr, 4, count.index + 4) : null
  map_public_ip_on_launch = false

  # FIX: Only attempt cidrsubnet if IPv6 CIDR is not empty
  ipv6_cidr_block = local.vpc_ipv6_cidr != "" ? cidrsubnet(
    local.vpc_ipv6_cidr,
    local.new_subnet_bits,
    count.index + local.firewall_index_offset
  ) : null

  # Only assign if we actually have an IPv6 block
  assign_ipv6_address_on_creation = local.vpc_ipv6_cidr != "" ? true : false

  tags = merge(
    {
      Name            = "${var.application}-${var.env}-pvt-subnet-fw-${var.azs[count.index]}"
      "Resource Type" = "pvt-subnet-fw"
      "Environment"   = var.environment
      "Application"   = var.application
      "Created by"    = "Cloud Network Team"
      "Region"        = var.region
    },
    var.base_tags
  )
}