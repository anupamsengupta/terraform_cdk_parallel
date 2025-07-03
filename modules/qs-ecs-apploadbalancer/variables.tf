variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "internet_facing" {
  description = "Whether the ALB is internet-facing"
  type        = bool
}

variable "port" {
  description = "Port for the ALB listener"
  type        = number
}

variable "security_group_id" {
  description = "ID of the security group for the ALB"
  type        = string
}

variable "unhealthy_threshold_count" {
  description = "Number of unhealthy threshold counts"
  type        = number
  default     = 10
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 10
}

variable "timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 8
}

variable "task_name" {
  description = "Name of the ECS task for target group"
  type        = string
  default     = ""
}

variable "task_port" {
  description = "Port for the ECS task"
  type        = number
  default     = 80
}

variable "priority" {
  description = "Priority for the listener rule"
  type        = number
  default     = 1
}

variable "services_list" {
  description = "List of services to be created"
  type        = list(string)
}

