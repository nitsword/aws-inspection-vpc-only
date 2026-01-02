## TGW Subnet Outputs
output "private_tg_subnet_ids" {
  description = "List of IDs for TGW subnets"
  
  value       = [for s in aws_subnet.private_tg : s.id]
}

output "private_tg_subnet_ipv4_cidrs" {
  description = "List of IPv4 CIDRs for TGW subnets"
  value       = [for s in aws_subnet.private_tg : s.cidr_block]
}

output "private_tg_subnet_ipv6_prefixes" {
  description = "List of IPv6 CIDRs for TGW subnets"
  value       = [for s in aws_subnet.private_tg : s.ipv6_cidr_block]
}

## Firewall Subnet Outputs
output "private_firewall_subnet_ids" {
  description = "List of IDs for Firewall subnets"
  value       = [for s in aws_subnet.private_firewall : s.id]
}

output "private_firewall_subnet_ipv4_cidrs" {
  description = "List of IPv4 CIDRs for Firewall subnets"
  value       = [for s in aws_subnet.private_firewall : s.cidr_block]
}

output "private_firewall_subnet_ipv6_prefixes" {
  description = "List of IPv6 CIDRs for Firewall subnets"
  value       = [for s in aws_subnet.private_firewall : s.ipv6_cidr_block]
}


output "tg_subnet_az_map" {
  value = { for k, v in aws_subnet.private_tg : k => v.id }
}

output "fw_subnet_az_map" {
  value = { for k, v in aws_subnet.private_firewall : k => v.id }
}