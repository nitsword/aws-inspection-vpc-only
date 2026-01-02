## Subnet Derivation Locals
locals {
  new_subnet_bits       = 8
  fw_index_offset = 10
}

## Private Transit Gateway (TG) Subnets
resource "aws_subnet" "private_tg" {
  for_each = var.tgw_subnet_cidrs

  vpc_id            = var.vpc_id
  availability_zone = each.key
  cidr_block        = each.value
  
  map_public_ip_on_launch = false

  ipv6_cidr_block = var.vpc_ipv6_cidr_primary != "" ? cidrsubnet(
    var.vpc_ipv6_cidr_primary,
    local.new_subnet_bits,
    index(var.azs, each.key)
  ) : null

  assign_ipv6_address_on_creation = var.vpc_ipv6_cidr_primary != "" ? true : false

  tags = merge(
    {
      Name            = "${var.application}-${var.env}-pvt-subnet-tg-${each.key}"
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
  for_each = var.fw_subnet_cidrs

  vpc_id            = var.vpc_id
  availability_zone = each.key
  cidr_block        = each.value
  
  map_public_ip_on_launch = false

  ipv6_cidr_block = var.vpc_ipv6_cidr_primary != "" ? cidrsubnet(
    var.vpc_ipv6_cidr_primary,
    local.new_subnet_bits,
    index(var.azs, each.key) + local.fw_index_offset # Uses 10, 11, 12
  ) : null

  assign_ipv6_address_on_creation = var.vpc_ipv6_cidr_primary != "" ? true : false

  tags = merge(
    {
      Name            = "${var.application}-${var.env}-pvt-subnet-fw-${each.key}"
      "Resource Type" = "pvt-subnet-fw"
      "Environment"   = var.environment
      "Application"   = var.application
      "Created by"    = "Cloud Network Team"
      "Region"        = var.region
    },
    var.base_tags
  )
}