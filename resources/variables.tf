variable "context" {
  description = "Context from the root label module"
  type        = any
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
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
