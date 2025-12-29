terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.54"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  
  ipv4_ipam_pool_id     = var.ipv4_ipam_pool_id
  ipv4_netmask_length   = var.ipv4_netmask_length
  ipv6_ipam_pool_id     = var.ipv6_ipam_pool_id
  azs                   = var.azs
  application           = var.application
  environment           = var.environment
  env                   = var.env
  region                = var.region
  base_tags             = var.base_tags
  vpc_netmask           = var.vpc_netmask
  secondary_cidr_blocks = var.secondary_cidr_blocks
}

module "subnets" {
  source        = "./modules/subnets"
  vpc_id        = module.vpc.vpc_id
  azs           = var.azs
  application   = var.application
  environment   = var.environment
  region        = var.region
  env           = var.env
  base_tags     = var.base_tags
  vpc_ipv6_cidr = module.vpc.vpc_ipv6_cidr_block

  depends_on = [module.vpc]
}

module "security_groups" {
  source                          = "./modules/security_groups"
  vpc_id                          = module.vpc.vpc_id
  application                     = var.application
  environment                     = var.environment
  region                          = var.region
  env                             = var.env
  base_tags                       = var.base_tags
  tg_ipv4_cidrs                   = module.subnets.private_tg_subnet_ipv4_cidrs
  private_tg_subnet_ipv6_prefixes = module.subnets.private_tg_subnet_ipv6_prefixes
  depends_on                      = [module.subnets]
}

# Create the TGW Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids             = module.subnets.private_firewall_subnet_ids
  transit_gateway_id     = var.transit_gateway_id
  vpc_id                 = module.vpc.vpc_id
  ipv6_support           = "enable"
  dns_support            = "enable"
  appliance_mode_support = "enable"

  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true
  depends_on = [
    module.vpc,
    module.subnets
  ]

  tags = merge(
    {
      Name            = "${var.application}-${var.env}-inspection-vpc-${var.region}-tgw-attachment"
      "Resource Type" = "tgw-attachment"
      "Environment"   = var.environment
      "Region"        = var.region
      "Application"   = var.application
      "Created by"    = "Cloud Network Team"
    },
    var.base_tags
  )
}

module "route_tables" {
  source                      = "./modules/route_tables"
  vpc_id                      = module.vpc.vpc_id
  application                 = var.application
  environment                 = var.environment
  region                      = var.region
  azs                         = var.azs
  env                         = var.env
  base_tags                   = var.base_tags
  transit_gateway_id          = var.transit_gateway_id
  tgw_attachment_id           = aws_ec2_transit_gateway_vpc_attachment.this.id
  enable_ipv6                 = true
  private_tg_subnets_full     = module.subnets.private_tg_subnets
  private_tg_subnet_ids       = module.subnets.private_tg_subnet_ids
  private_firewall_subnet_ids = module.subnets.private_firewall_subnet_ids
}

module "secure_s3_bucket" {
  source                 = "./modules/s3_bucket"
  application            = var.application
  environment            = var.environment
  env                    = var.env
  base_tags              = var.base_tags
  bucket_name            = var.bucket_name
  allowed_principal_arns = ["arn:aws:iam::359416636780:user/terraform-test"]
}