variable "context" {
  description = "Context from the root label module"
  type        = any
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "task_name" {
  description = "Name of the ECS task"
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

variable "repo_tag" {
  description = "Tag of the ECR repository image"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
}

variable "environment_vars" {
  description = "Environment variables for the container"
  type        = map(string)
}

variable "memory_limit_mib" {
  description = "Memory limit in MiB"
  type        = number
  default     = 1024
}

variable "cpu" {
  description = "CPU units for the task"
  type        = number
  default     = 512
}

variable "mapped_port" {
  description = "Port mapping for the container"
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1
}

variable "use_service_discovery" {
  description = "Enable service discovery"
  type        = bool
  default     = false
}

variable "use_service_connect_proxy" {
  description = "Enable service connect proxy"
  type        = bool
  default     = false
}

variable "service_discovery_namespace_id" {
  description = "ID of the service discovery namespace"
  type        = string
  default     = ""
}

variable "service_discovery_namespace_name" {
  description = "Name of the service discovery namespace"
  type        = string
  default     = ""
}

variable "is_autoscaling_enabled" {
  description = "Enable autoscaling"
  type        = bool
  default     = false
}

variable "autoscaling_min_capacity" {
  description = "Minimum capacity for autoscaling"
  type        = number
  default     = 1
}

variable "autoscaling_max_capacity" {
  description = "Maximum capacity for autoscaling"
  type        = number
  default     = 1
}

variable "autoscaling_requests_per_target" {
  description = "Requests per target for autoscaling"
  type        = number
  default     = 100
}

variable "autoscaling_cpu_percentage" {
  description = "CPU percentage for autoscaling"
  type        = number
  default     = 70
}

variable "autoscaling_memory_percentage" {
  description = "Memory percentage for autoscaling"
  type        = number
  default     = 70
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
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

