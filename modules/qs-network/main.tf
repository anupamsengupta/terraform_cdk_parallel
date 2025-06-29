
# Defining the VPC using Cloud Posse's terraform-aws-vpc module
module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.2.0"

  name                             = "${var.stack_name}-vpc"
  ipv4_primary_cidr_block          = var.vpc_cidr
  assign_generated_ipv6_cidr_block = false


  # Enable DNS hostnames and support for better resolution
  dns_hostnames_enabled    = true
  dns_support_enabled      = true
  enabled                  = true
  internet_gateway_enabled = true

  tags = {
    Name = "${var.stack_name}-vpc"
  }
  context = var.context
}

# Defining subnets using Cloud Posse's terraform-aws-dynamic-subnets module
module "dynamic_subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.4.2"

  vpc_id               = module.vpc.vpc_id
  availability_zones   = var.azs
  igw_id               = [module.vpc.igw_id]
  enabled              = true
  ipv4_enabled         = true
  ipv6_enabled         = false
  ipv4_cidr_block      = [module.vpc.vpc_cidr_block]
  ipv6_cidr_block      = [module.vpc.vpc_ipv6_cidr_block]
  nat_gateway_enabled  = false
  nat_instance_enabled = false
  route_create_timeout = "5m"
  route_delete_timeout = "10m"

  subnet_type_tag_key = "cpco.io/subnet/type"

  subnets_per_az_count = var.subnets_per_az_count
  subnets_per_az_names = var.subnets_per_az_names


  tags = {
    Name = "${var.stack_name}-subnets"
  }
  context = var.context
}

# S3 Gateway Endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = module.dynamic_subnets.private_route_table_ids
}

# DynamoDB Gateway Endpoint
resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = module.dynamic_subnets.private_route_table_ids
}

# Security Groups
module "no_access_sg" {
  source  = "cloudposse/security-group/aws"
  version = "2.2.0"

  vpc_id = module.vpc.vpc_id
  name   = "${var.stack_name}-Default-NO-Access-SG"
  //description                = "Default-NO-Access-SG"
  allow_all_egress      = false
  create_before_destroy = true

  tags = {
    Name = "${var.stack_name}-Default-NO-Access-SG"
  }
  context = var.context
}

module "http_access_sg" {
  source  = "cloudposse/security-group/aws"
  version = "2.2.0"

  vpc_id = module.vpc.vpc_id
  name   = "${var.stack_name}-Default-HTTP-Access-SG"
  //description                = "Default-HTTP-Access-SG"
  allow_all_egress      = true
  create_before_destroy = true

  rules = [
    {
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
      description = "Allow traffic from NLB"
    }
  ]

  tags = {
    Name = "${var.stack_name}-Default-HTTP-Access-SG"
  }
  context = var.context
}

module "https_access_sg" {
  source  = "cloudposse/security-group/aws"
  version = "2.2.0"

  vpc_id = module.vpc.vpc_id
  name   = "${var.stack_name}-Default-HTTPS-Access-SG"
  //description                = "Default-HTTPS-Access-SG"
  allow_all_egress      = true
  create_before_destroy = true

  rules = [
    {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
      description = "Allow traffic from NLB"
    }
  ]

  tags = {
    Name = "${var.stack_name}-Default-HTTPS-Access-SG"
  }
  context = var.context
}

module "rds_postgres_access_sg" {
  source  = "cloudposse/security-group/aws"
  version = "2.2.0"

  vpc_id = module.vpc.vpc_id
  name   = "${var.stack_name}-Default-RDS-POSTGRESS-Access-SG"
  //description                = "Default-RDS-POSTGRESS-Access-SG"
  allow_all_egress      = true
  create_before_destroy = true

  rules = [
    {
      type        = "ingress"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
      description = "Allow DB traffic from CIDR"
    }
  ]

  tags = {
    Name = "${var.stack_name}-Default-RDS-POSTGRESS-Access-SG"
  }
  context = var.context
}

module "rds_mysql_access_sg" {
  source  = "cloudposse/security-group/aws"
  version = "2.2.0"

  vpc_id = module.vpc.vpc_id
  name   = "${var.stack_name}-Default-RDS-MYSQL-Access-SG"
  //description                = "Default-RDS-MYSQL-Access-SG"
  allow_all_egress      = true
  create_before_destroy = true

  rules = [
    {
      type        = "ingress"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
      description = "Allow DB traffic from CIDR"
    }
  ]

  tags = {
    Name = "${var.stack_name}-Default-RDS-MYSQL-Access-SG"
  }
  context = var.context
}

# Data source for AWS region
data "aws_region" "current" {}