resource "aws_security_group" "firewall_sg" {
  name        = "${var.application}-${var.env}-firewall-sg"
  description = "Security group for firewall endpoints"
  vpc_id      = var.vpc_id

  # Inbound Rules
  ingress {
    description      = "Allow inbound traffic from TG subnets"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    
    cidr_blocks      = compact(var.tg_ipv4_cidrs)
    ipv6_cidr_blocks = compact(var.private_tg_subnet_ipv6_prefixes)
  }

  # Outbound Rules
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    {
      Name            = "${var.application}-${var.env}-firewall-sg-${var.region}"
      "Resource Type" = "security-group"
      "Environment"   = var.environment
      "Application"   = var.application
      "Created by"    = "Cloud Network Team"
      "Region"        = var.region
    }, 
    var.base_tags
  )
}