
# 1. Route tables for private_tg subnets (one per subnet)
resource "aws_route_table" "private_tg" {
  count  = length(var.private_tg_subnet_ids)
  vpc_id = var.vpc_id
  tags = merge({
    Name = "${var.application}-${var.env}-vpc-pvt-tg-subnet-rttb-${var.private_tg_subnets_full[count.index].availability_zone}"
    "Resource Type" = "route-table-tg"
    "Creation Date" = timestamp()
    "Environment" = var.environment
    "Application" = var.application
    "Created by" = "Cloud Network Team"
    "Region" = var.region
  }, var.base_tags)
}

# Associate each private_tg subnet with its route table
resource "aws_route_table_association" "private_tg_assoc" {
  count          = length(var.private_tg_subnet_ids)
  subnet_id      = var.private_tg_subnet_ids[count.index]
  route_table_id = aws_route_table.private_tg[count.index].id
}

# 2. Single route table for all private_firewall subnets
resource "aws_route_table" "firewall" {
  vpc_id = var.vpc_id
  tags = merge({
    Name = "${var.application}-${var.env}-vpc-pvt-fw-subnet-rttb-${var.region}"
    "Resource Type" = "route-table-fw"
    "Creation Date" = timestamp()
    "Environment" = var.environment
    "Application" = var.application
    "Created by" = "Cloud Network Team"
    "Region" = var.region
  }, var.base_tags)
}

# Associate all private_firewall subnets with the firewall route table
resource "aws_route_table_association" "firewall_assoc" {
  count          = length(var.private_firewall_subnet_ids)
  subnet_id      = var.private_firewall_subnet_ids[count.index]
  route_table_id = aws_route_table.firewall.id
}