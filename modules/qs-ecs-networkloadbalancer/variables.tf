variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the NLB"
  type        = list(string)
}

variable "internet_facing" {
  description = "Whether the NLB is internet-facing"
  type        = bool
}

variable "port" {
  description = "Port for the NLB listener"
  type        = number
}

variable "application_listener_arn" {
  description = "ARN of the application load balancer listener"
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