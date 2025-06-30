
variable "context" {
  description = "Context from the root label module"
  type        = any
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "service_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "service_discovery_namespace" {
  description = "Name of the service discovery namespace"
  type        = string
}