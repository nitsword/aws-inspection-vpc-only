output "vpc_id" {
  value = aws_vpc.inspection_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.inspection_vpc.cidr_block
}

output "vpc_ipv6_cidr_block" { 
  value = try(aws_vpc_ipv6_cidr_block_association.secondary_ipv6[0].ipv6_cidr_block, "")
}

output "secondary_ipv4_cidr_blocks" {
  value = [for assoc in aws_vpc_ipv4_cidr_block_association.secondary_cidr : assoc.cidr_block]
}