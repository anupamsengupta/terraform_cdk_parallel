variable "region" {
  description = "AWS region"
  type        = string
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
  default     = "qs-example"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_cidrs" {
  description = "CIDR block for the VPC"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "backend_ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
}

variable "backend_context_path" {
  description = "spring boot context path for backend"
  type        = string
}

variable "frontend_ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
}

variable "frontend1_context_path" {
  description = "spring boot context path for backend"
  type        = string
}

variable "frontend2_context_path" {
  description = "spring boot context path for backend"
  type        = string
}

variable "environment_vars" {
  description = "Environment variables for the ECS task"
  type        = map(string)
  default     = {}
}

variable "eventbridge_enabled" {
  description = "Enable EventBridge notifications"
  type        = bool
}

variable "event_notification_enabled" {
  description = "Enable S3 event notifications to SQS"
  type        = bool
}

variable "test_queue_name" {
  description = "Name of the SQS queue for notifications"
  type        = string
}

variable "notification_queue_name" {
  description = "Name of the SQS queue for notifications"
  type        = string
}

variable "versioned" {
  description = "Enable versioning for the bucket"
  type        = bool
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout in seconds"
  type        = number
}

variable "enable_dlq" {
  description = "Enable dead letter queue"
  type        = bool
}

variable "filter_prefix" {
  description = "Prefix for S3 event notifications"
  type        = string
}

variable "filter_suffix" {
  description = "Suffix for S3 event notifications"
  type        = string
}

variable "object_expiration_days" {
  description = "Retention period for the object in s3 bucket in days"
  type        = number
}

variable "noncurrent_version_expiration_days" {
  description = "Retention period for the non current object in s3 bucket in days"
  type        = number
}

variable "object_transition_standardia_days" {
  description = "Transition period for the object in s3 bucket in days to standard IA"
  type        = number
}

variable "object_transition_onezoneia_days" {
  description = "Retention period for the object in s3 bucket in days to one-zone IA"
  type        = number
}

variable "service_discovery_namespace" {
  description = "Service discovery namespace for ECS"
  type        = string
}

variable "services_list" {
  description = "List of services to be created"
  type        = list(string)
}

variable "default_tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    Environment = "TEST"
    Project     = "CloudSample1"
    ManagedBy   = "Terraform"
    Ticket      = "ICRQ-1884"
  }
}
