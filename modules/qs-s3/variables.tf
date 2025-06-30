variable "region" {
  description = "AWS region"
  type        = string
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "block_public_access" {
  description = "Whether to block public access to the bucket"
  type        = bool
  default     = true
}

variable "public_read_access" {
  description = "Whether to allow public read access to the bucket"
  type        = bool
  default     = false
}

variable "removal_policy" {
  description = "Bucket removal policy (DESTROY or RETAIN)"
  type        = string
  default     = "DESTROY"
}

variable "versioned" {
  description = "Enable versioning for the bucket"
  type        = bool
}

variable "eventbridge_enabled" {
  description = "Enable EventBridge notifications"
  type        = bool
}

variable "event_notification_enabled" {
  description = "Enable S3 event notifications to SQS"
  type        = bool
}

variable "notification_queue_name" {
  description = "Name of the SQS queue for notifications"
  type        = string
}

variable "notification_queue_visibility_timeout" {
  description = "Visibility timeout for the notification queue in seconds"
  type        = number
  default     = 15
}

variable "notification_queue_retention_period" {
  description = "Retention period for the notification queue in days"
  type        = number
  default     = 5
}

variable "sse_algorithm" {
  description = "Retention period for the notification queue in days"
  type        = string
  default     = "AES256"
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
