/*
module "ecs_cluster" {
  source  = "cloudposse/ecs-cluster/aws"
  version = "0.9.0"

  name                       = "${var.stack_name}-${var.service_cluster_name}"
  container_insights_enabled = true
  capacity_providers_fargate = true
  //capacity_providers_fargate_spot = true
  capacity_providers_ec2 = {}
  context                = var.context
  tags = {
    Name = "${var.stack_name}-${var.service_cluster_name}"
  }
}

module "service_discovery" {
  source  = "cloudposse/service-discovery/aws"
  version = "0.4.0"

  name           = "${var.stack_name}-${var.service_cluster_name}-${var.service_discovery_namespace}"
  vpc_id         = var.vpc_id
  namespace_type = "DNS_PRIVATE"

  tags = {
    Name = "${var.stack_name}-${var.service_cluster_name}-${var.service_discovery_namespace}"
  }
}

*/

# ECS Cluster
resource "aws_ecs_cluster" "main_cluster" {
  name = "${var.stack_name}-${var.service_cluster_name}"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.stack_name}-${var.service_cluster_name}"
  }
}

# ECS Cluster Capacity Providers (Fargate)
resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.main_cluster.name
  capacity_providers = ["FARGATE"]
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.stack_name}-${var.service_cluster_name}-ecs-task-executionrole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.stack_name}-${var.service_cluster_name}-ecs-task-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
  "arn:aws:iam::aws:policy/AmazonSSMFullAccess"]
}


/*
module "task_execution_role" {
  source  = "cloudposse/iam-role/aws"
  version = "0.16.2"

  role_description = "ECS Task Execution Role for ${var.stack_name} - ${var.service_cluster_name}"
  name             = "${var.stack_name}-${var.service_cluster_name}-task-execution-role"
  principals = {
    "Service" = ["ecs-tasks.amazonaws.com"]
  }
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]

  context = var.context
  tags = {
    Name = "${var.stack_name}-${var.service_cluster_name}-task-execution-role"
  }
}

module "task_role" {
  source  = "cloudposse/iam-role/aws"
  version = "0.16.2"

  role_description = "ECS Task Role for ${var.stack_name} - ${var.service_cluster_name}"
  context          = var.context
  name             = "${var.stack_name}-${var.service_cluster_name}-task-role"
  principals = {
    "Service" = ["ecs-tasks.amazonaws.com"]
  }
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
    Name = "${var.stack_name}-${var.service_cluster_name}-task-role"
  }
}
*/