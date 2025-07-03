variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "http_security_group_id" {
  description = "ID of the HTTP security group"
  type        = string
}

variable "backend_service" {
  description = "Name of the backend service"
  type        = string
}

variable "frontend1_service" {
  description = "Name of the first frontend service"
  type        = string
}

variable "frontend2_service" {
  description = "Name of the second frontend service"
  type        = string
}

variable "services_map" {
  description = "Map of service names to their configurations"
  type        = map(any)
  default = {
    backend = {
      service_name = var.backend_service
      task_name    = "backend"
    }
    frontend1 = {
      service_name = var.frontend1_service
      task_name    = "frontend1"
    }
    frontend2 = {
      service_name = var.frontend2_service
      task_name    = "frontend2"
    }
  }
}

variable "services_list" {
  description = "List of services to be created"
  type        = list(string)
}

