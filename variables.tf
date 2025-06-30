variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
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

variable "ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
  default     = "123456789012.dkr.ecr.us-east-1.amazonaws.com/example-repo"
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
