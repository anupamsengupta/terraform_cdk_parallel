variable "context" {
  description = "Context from the root label module"
  type        = any
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "context_path" {
  description = "Context path for the backend service"
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
}

variable "http_security_group_id" {
  description = "ID of the HTTP security group"
  type        = string
}

variable "service_discovery_namespace_id" {
  description = "ID of the service discovery namespace"
  type        = string
}

variable "service_discovery_namespace_name" {
  description = "Name of the service discovery namespace"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

/*
variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}
*/

variable "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}
