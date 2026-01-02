output "vpc_id" {
  value = aws_vpc.inspection_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.inspection_vpc.cidr_block
}

output "secondary_ipv4_cidr_blocks" {
  description = "List of secondary IPv4 CIDR blocks"
  value       = [aws_vpc_ipv4_cidr_block_association.secondary_cidr.cidr_block]
}

output "vpc_ipv6_cidr_primary" {
  value = aws_vpc.inspection_vpc.ipv6_cidr_block
}

# output "vpc_ipv6_cidr_secondary" {
#   value = aws_vpc_ipv6_cidr_block_association.secondary_ipv6.ipv6_cidr_block
# }