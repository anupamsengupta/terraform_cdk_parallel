module "ecs_task" {
  source = "../modules/qs-ecs-task"

  context                     = var.context
  stack_name                  = var.stack_name
  task_name                   = var.context_path
  cluster_arn                 = var.cluster_arn
  ecr_repository_url          = var.ecr_repository_url
  repo_tag                    = "latest"
  security_group_id           = var.http_security_group_id
  ecs_task_execution_role_arn = var.ecs_task_execution_role_arn
  ecs_task_role_arn           = var.ecs_task_role_arn
  environment_vars = {
    DB_URL            = "db@serviceIP:onPort"
    secretsmanagerkey = "secretsmanagerkey_value"
    EXTERNAL_GET_URL1 = "http://localhost/backend/api/external-api"
    EXTERNAL_GET_URL2 = "http://localhost/backend/api/greet"
    APP_CONTEXT_PATH  = "/${var.context_path}"
  }
  memory_limit_mib                 = 1024
  cpu                              = 512
  mapped_port                      = 80
  desired_count                    = 1
  use_service_discovery            = false
  use_service_connect_proxy        = true
  service_discovery_namespace_id   = var.service_discovery_namespace_id
  service_discovery_namespace_name = var.service_discovery_namespace_name
  is_autoscaling_enabled           = true
  autoscaling_cpu_percentage       = 80
  autoscaling_memory_percentage    = 90
  autoscaling_requests_per_target  = 200
  autoscaling_min_capacity         = 1
  autoscaling_max_capacity         = 3
  vpc_id                           = var.vpc_id
  subnet_ids                       = var.private_subnet_ids
  //target_group_arn                 = var.target_group_arn

}

/*
module "task_execution_role" {
  source  = "cloudposse/iam-role/aws"
  version = "0.16.2"

  name                = "${var.stack_name}-${var.context_path}-task-execution-role"
  principals          = ["ecs-tasks.amazonaws.com"]
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonECS_FullAccess"]

  tags = {
    Name         = "${var.stack_name}-${var.context_path}-task-execution-role"
    Environment  = "RnD"
    billing-code = "ICRQ-1843"
  }
}

module "task_role" {
  source  = "cloudposse/iam-role/aws"
  version = "0.16.2"

  name       = "${var.stack_name}-${var.context_path}-task-role"
  principals = ["ecs-tasks.amazonaws.com"]
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  ]

  tags = {
    Name         = "${var.stack_name}-${var.context_path}-task-role"
    Environment  = "RnD"
    billing-code = "ICRQ-1843"
  }
}
*/