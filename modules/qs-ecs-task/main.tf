

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${var.stack_name}-${var.task_name}"
  retention_in_days = 14

  tags = {
    Name = "${var.stack_name}-${var.task_name}-log-group"
  }
}



/*
module "container_definition" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.61.2"

  //context          = var.context
  container_name   = "${var.stack_name}-${var.task_name}"
  container_image  = "${var.ecr_repository_url}:${var.repo_tag}"
  essential        = true
  container_memory = var.memory_limit_mib
  container_cpu    = var.cpu
  environment      = [for k, v in var.environment_vars : { name = k, value = v }]
  port_mappings = [
    {
      containerPort = var.mapped_port
      hostPort      = var.mapped_port
      protocol      = "tcp"
      name          = "${var.stack_name}-${var.task_name}-app-port"
    }
  ]
  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
      "awslogs-region"        = data.aws_region.current.name
      "awslogs-stream-prefix" = "${var.stack_name}-${var.task_name}"
    }
  }
}


module "ecs_alb_service_task" {
  source  = "cloudposse/ecs-alb-service-task/aws"
  version = "0.78.0"

  context                        = var.context
  name                           = "${var.stack_name}-${var.task_name}"
  alb_security_group             = var.alb_security_group_id
  container_definition_json      = "[${module.container_definition.json_map_encoded}]"
  ecs_cluster_arn                = var.cluster_arn
  launch_type                    = "FARGATE"
  vpc_id                         = var.vpc_id
  subnet_ids                     = var.subnet_ids
  security_group_ids             = [var.alb_security_group_id]
  ignore_changes_task_definition = true
  assign_public_ip               = false
  propagate_tags                 = "SERVICE"
  desired_count                  = 1
  task_memory                    = var.memory_limit_mib
  task_cpu                       = var.cpu
  network_mode                   = "awsvpc"
  enabled                        = true
  task_exec_role_arn             = [var.ecs_task_execution_role_arn]
  task_role_arn                  = [var.ecs_task_role_arn]

  service_connect_configurations = [
    {
      enabled   = true
      namespace = var.service_discovery_namespace_name

      log_configuration = {
        log_driver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = data.aws_region.current.name
          "awslogs-stream-prefix" = "${var.task_name}-api-service-connect"
        }
      }

      services = [
        {
          port_name = "${var.stack_name}-${var.task_name}-app-port"
          //port      = var.mapped_port
          client_alias = [
            {
              dns_name = "${var.task_name}"
              port     = 80
            }
          ]
          timeout = [
            {
              idle_timeout_seconds        = 60
              per_request_timeout_seconds = 60
            }
          ]
          discovery_name        = "${var.task_name}"
          //ingress_port_override = 80
        }
      ]
    }
  ]
}
*/
data "aws_region" "current" {}