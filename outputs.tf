# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

output "private_tg_subnet_ids" {
  value = module.subnets.private_tg_subnet_ids
}

output "private_firewall_subnet_ids" {
  value = module.subnets.private_firewall_subnet_ids
}


output "vpc_ipv6_cidr_primary" {
  value = module.vpc.vpc_ipv6_cidr_primary
}


output "firewall_sg_id" {
  value = module.security_groups.firewall_sg_id
}