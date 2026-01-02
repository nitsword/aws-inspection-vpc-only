application = "ntw"
environment = "Non-production::Dev"
env = "dev"
region = "us-east-1"
azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

# --- IPAM Configuration ---

ipv4_ipam_pool_id = "ipam-pool-07abd85616508f997" 
ipv6_ipam_pool_id = "ipam-pool-03d0ef2de9a295124"
secondary_cidr_blocks = ["internal-services"]

# VPC Ranges
vpc_primary_cidr   = "100.127.1.0/25"
vpc_secondary_cidr = "100.127.2.0/25"

# IPv6 Ranges
vpc_primary_ipv6_cidr   = "fd04:cd00:4980:ff00::/56"
#vpc_secondary_ipv6_cidr = "fd04:cd00:4980:ff01::/60"

# Subnet CIDRs (Splitting the /25 into /27s)
# TGW Subnets
# TGW Subnets (from Primary 100.127.1.0/25)
tgw_subnet_cidrs = {
  "us-east-1a" = "100.127.1.0/28"
  "us-east-1b" = "100.127.1.16/28"
  "us-east-1c" = "100.127.1.32/28"
}

# Firewall Subnets (from Secondary 100.127.2.0/25)
fw_subnet_cidrs = {
  "us-east-1a" = "100.127.2.0/28"
  "us-east-1b" = "100.127.2.16/28"
  "us-east-1c" = "100.127.2.32/28"
}

#transit_gateway_id = "tgw-00d08c76bf62baaa7"
transit_gateway_id = "tgw-09396a29da000e3c8"



 