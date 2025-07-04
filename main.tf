provider "aws" {
  region = var.region
  default_tags {
    tags = var.default_tags
  }
}

module "label" {
  source = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"
  namespace  = "quickysoft"
  stage      = "dev"
  name       = "erpconnect"
  attributes = ["public"]
  delimiter  = "-"

  tags = {
    "BusinessUnit" = "internal-1",
    "Snapshot"     = "true"
  }
}

module "qs_network" {
  source = "./modules/qs-network"

  stack_name                  = var.stack_name
  vpc_cidr                    = var.vpc_cidr
  vpc_cidrs                   = var.vpc_cidrs
  azs                         = var.azs
  context                     = module.label.context
  service_discovery_namespace = var.service_discovery_namespace
}

module "resources" {
  source = "./resources"

  context                            = module.label.context
  region                             = var.region
  stack_name                         = var.stack_name
  event_notification_enabled         = var.event_notification_enabled
  eventbridge_enabled                = var.eventbridge_enabled
  test_queue_name                    = var.test_queue_name
  notification_queue_name            = var.notification_queue_name
  versioned                          = var.versioned
  visibility_timeout_seconds         = var.visibility_timeout_seconds
  enable_dlq                         = var.enable_dlq
  filter_prefix                      = var.filter_prefix
  filter_suffix                      = var.filter_suffix
  object_expiration_days             = var.object_expiration_days
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  object_transition_standardia_days  = var.object_transition_standardia_days
  object_transition_onezoneia_days   = var.object_transition_onezoneia_days
}

module "qs_ecs_cluster" {
  source = "./modules/qs-ecs-cluster"

  context                     = module.label.context
  stack_name                  = var.stack_name
  service_cluster_name        = "${var.stack_name}-svcCluster"
  vpc_id                      = module.qs_network.vpc_id
  service_discovery_namespace = var.service_discovery_namespace
}

module "backend" {
  source = "./backend"

  context                          = module.label.context
  stack_name                       = var.stack_name
  context_path                     = var.backend_context_path
  cluster_arn                      = module.qs_ecs_cluster.cluster_arn
  ecr_repository_url               = var.backend_ecr_repository_url
  http_security_group_id           = module.qs_network.http_access_sg_id
  vpc_id                           = module.qs_network.vpc_id
  private_subnet_ids               = module.qs_network.private_subnets
  ecs_task_execution_role_arn      = module.qs_ecs_cluster.task_execution_role_arn
  ecs_task_role_arn                = module.qs_ecs_cluster.task_role_arn
  alb_security_group_id            = module.qs_network.http_access_sg_id
  subnet_ids                       = module.qs_network.private_subnets
  service_discovery_namespace_name = module.qs_network.service_discovery_namespace_name
  service_discovery_namespace_id   = module.qs_network.service_discovery_namespace_id
  //target_group_arn                 = module.api.backend_target_group_arn
}

/*
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