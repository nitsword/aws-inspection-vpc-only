application = "ntw"
environment = "Non-production::Dev"
env = "dev"
region = "us-east-1"
azs = ["us-east-1a", "us-east-1b", "us-east-1d"]

# --- IPAM Configuration ---

ipv4_ipam_pool_id = "ipam-pool-08ea4a23183be6f2c" 
ipv6_ipam_pool_id = "ipam-pool-09b81122158ca689a"
secondary_cidr_blocks = ["internal-services"]

# Netmask for the VPC (e.g., 16 = /16)
vpc_netmask       = 16

#transit_gateway_id = "tgw-00d08c76bf62baaa7"
transit_gateway_id = "tgw-09396a29da000e3c8"
 