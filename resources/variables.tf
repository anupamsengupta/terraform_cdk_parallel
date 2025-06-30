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
