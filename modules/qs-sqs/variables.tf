
variable "context" {
  description = "Context from the root label module"
  type        = any
}

variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "delivery_delay_seconds" {
  description = "Delivery delay in seconds"
  type        = number
  default     = 2
}

variable "max_message_size_bytes" {
  description = "Maximum message size in bytes"
  type        = number
  default     = 256 * 1024
}

variable "receive_message_wait_time_seconds" {
  description = "Receive message wait time in seconds"
  type        = number
  default     = 2
}

variable "retention_period_days" {
  description = "Message retention period in days"
  type        = number
  default     = 5
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout in seconds"
  type        = number
}

variable "max_receive_count" {
  description = "Maximum receive count before moving to DLQ"
  type        = number
  default     = 5
}

variable "enable_dlq" {
  description = "Enable dead letter queue"
  type        = bool
}
