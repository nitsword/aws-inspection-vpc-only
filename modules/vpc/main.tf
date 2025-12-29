resource "aws_vpc" "inspection_vpc" {
  ipv4_ipam_pool_id   = var.ipv4_ipam_pool_id
  # FIX: Match the variable name to your tfvars
  ipv4_netmask_length = var.vpc_netmask 

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name            = "${var.application}-${var.env}-inspection-vpc-${var.region}"
      "Resource Type" = "inspection-vpc"
      "Environment"   = var.environment
      "Application"   = var.application
      "Created by"    = "Cloud Network Team"
      "Region"        = var.region
    },
    var.base_tags
  )
}

# Secondary IPv4 using IPAM
resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  for_each            = toset(var.secondary_cidr_blocks)
  vpc_id              = aws_vpc.inspection_vpc.id
  ipv4_ipam_pool_id   = var.ipv4_ipam_pool_id
  ipv4_netmask_length = 24 

  depends_on = [aws_vpc.inspection_vpc]

  lifecycle {
    create_before_destroy = false
  }
}

# Secondary IPv6 using IPAM
resource "aws_vpc_ipv6_cidr_block_association" "secondary_ipv6" {
  count               = var.ipv6_ipam_pool_id != null ? 1 : 0
  vpc_id              = aws_vpc.inspection_vpc.id
  ipv6_ipam_pool_id   = var.ipv6_ipam_pool_id
  ipv6_netmask_length = 56

  depends_on = [aws_vpc.inspection_vpc]

  lifecycle {
    create_before_destroy = false
  }
}