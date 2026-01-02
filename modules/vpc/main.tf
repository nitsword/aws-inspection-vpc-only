resource "aws_vpc" "inspection_vpc" {
  ipv4_ipam_pool_id = var.ipv4_ipam_pool_id
  cidr_block        = var.vpc_primary_cidr
  
  ipv6_ipam_pool_id = var.ipv6_ipam_pool_id
  ipv6_cidr_block   = var.vpc_primary_ipv6_cidr
  

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
  vpc_id              = aws_vpc.inspection_vpc.id
  ipv4_ipam_pool_id   = var.ipv4_ipam_pool_id
  cidr_block        = var.vpc_secondary_cidr

  depends_on = [aws_vpc.inspection_vpc]

  lifecycle {
    create_before_destroy = false
  }
}

# # Secondary IPv6 using IPAM
# resource "aws_vpc_ipv6_cidr_block_association" "secondary_ipv6" {
#   vpc_id              = aws_vpc.inspection_vpc.id
#   ipv6_ipam_pool_id   = var.ipv6_ipam_pool_id
#   ipv6_cidr_block   = var.vpc_secondary_ipv6_cidr

#   depends_on = [aws_vpc.inspection_vpc]

#   lifecycle {
#     create_before_destroy = false
#   }
# }