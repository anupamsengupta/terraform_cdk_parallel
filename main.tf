provider "aws" {
  region = var.region
  default_tags {
    tags = var.default_tags
  }
}

module "qs_network" {
  source = "./modules/qs-network"

  stack_name = var.stack_name
  vpc_cidr   = var.vpc_cidr
  vpc_cidrs = var.vpc_cidrs
  azs        = var.azs
}

/*
module "qs_ecs_cluster" {
  source = "./modules/qs-ecs-cluster"

  stack_name             = var.stack_name
  service_cluster_name   = "${var.stack_name}-svcCluster"
  vpc_id                 = module.qs_network.vpc_id
  service_discovery_namespace = var.service_discovery_namespace

  tags = {
    Environment   = "RnD"
    billing-code  = "ICRQ-1843"
  }
}

module "resources" {
  source = "./resources"

  stack_name = var.stack_name

  tags = {
    Environment   = "RnD"
    billing-code  = "ICRQ-1843"
  }
}

module "backend" {
  source = "./backend"

  stack_name                  = var.stack_name
  context_path                = var.backend_context_path
  cluster_arn                 = module.qs_ecs_cluster.cluster_arn
  ecr_repository_url          = var.ecr_repository_url
  http_security_group_id      = module.qs_network.http_access_sg_id
  service_discovery_namespace_id = module.qs_ecs_cluster.service_discovery_namespace_id
  service_discovery_namespace_name = module.qs_ecs_cluster.service_discovery_namespace_name
  vpc_id                      = module.qs_network.vpc_id
  private_subnet_ids          = module.qs_network.private_subnets
  target_group_arn            = module.api.backend_target_group_arn

  tags = {
    Environment   = "RnD"
    billing-code  = "ICRQ-1843"
  }
}

module "frontend1" {
  source = "./frontend"

  stack_name                  = var.stack_name
  context_path                = var.frontend1_context_path
  cluster_arn                 = module.qs_ecs_cluster.cluster_arn
  ecr_repository_url          = var.ecr_repository_url
  http_security_group_id      = module.qs_network.http_access_sg_id
  service_discovery_namespace_id = module.qs_ecs_cluster.service_discovery_namespace_id
  service_discovery_namespace_name = module.qs_ecs_cluster.service_discovery_namespace_name
  vpc_id                      = module.qs_network.vpc_id
  private_subnet_ids          = module.qs_network.private_subnets
  target_group_arn            = module.api.frontend1_target_group_arn

  tags = {
    Environment   = "RnD"
    billing-code  = "ICRQ-1843"
  }
}

module "frontend2" {
  source = "./frontend"

  stack_name                  = var.stack_name
  context_path                = var.frontend2_context_path
  cluster_arn                 = module.qs_ecs_cluster.cluster_arn
  ecr_repository_url          = var.ecr_repository_url
  http_security_group_id      = module.qs_network.http_access_sg_id
  service_discovery_namespace_id = module.qs_ecs_cluster.service_discovery_namespace_id
  service_discovery_namespace_name = module.qs_ecs_cluster.service_discovery_namespace_name
  vpc_id                      = module.qs_network.vpc_id
  private_subnet_ids          = module.qs_network.private_subnets
  target_group_arn            = module.api.frontend2_target_group_arn

  tags = {
    Environment   = "RnD"
    billing-code  = "ICRQ-1843"
  }
}

module "api" {
  source = "./api"

  stack_name          = var.stack_name
  cluster_arn         = module.qs_ecs_cluster.cluster_arn
  vpc_id              = module.qs_network.vpc_id
  public_subnet_ids   = module.qs_network.public_subnets
  private_subnet_ids  = module.qs_network.private_subnets
  http_security_group_id = module.qs_network.http_access_sg_id
  backend_service     = var.backend_context_path
  frontend1_service   = var.frontend1_context_path
  frontend2_service   = var.frontend2_context_path

  tags = {
    Environment   = "RnD"
    billing-code  = "ICRQ-1843"
  }
}
*/