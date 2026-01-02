# Route tables for private_tg subnets (one per AZ/subnet)
resource "aws_route_table" "private_tg" {
  for_each = var.tg_subnet_map
  vpc_id   = var.vpc_id

  tags = merge({
    Name            = "${var.application}-${var.env}-vpc-pvt-tg-subnet-rttb-${each.key}"
    "Resource Type" = "route-table-tg"
    "Creation Date" = timestamp()
    "Environment"   = var.environment
    "Application"   = var.application
    "Created by"    = "Cloud Network Team"
    "Region"        = var.region
  }, var.base_tags)
}

# Associate each private_tg subnet with its specific route table
resource "aws_route_table_association" "private_tg_assoc" {

  for_each       = var.tg_subnet_map
  subnet_id      = each.value
  route_table_id = aws_route_table.private_tg[each.key].id
}

# Single route table for all private_firewall subnets
resource "aws_route_table" "firewall" {
  vpc_id = var.vpc_id

  tags = merge({
    Name            = "${var.application}-${var.env}-vpc-pvt-fw-subnet-rttb-${var.region}"
    "Resource Type" = "route-table-fw"
    "Creation Date" = timestamp()
    "Environment"   = var.environment
    "Application"   = var.application
    "Created by"    = "Cloud Network Team"
    "Region"        = var.region
  }, var.base_tags)
}

# Associate all private_firewall subnets with the SINGLE firewall route table
resource "aws_route_table_association" "firewall_assoc" {
  for_each       = var.fw_subnet_map
  subnet_id      = each.value
  route_table_id = aws_route_table.firewall.id
}