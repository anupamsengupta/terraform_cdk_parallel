variable "stack_name" {
  description = "Name of the stack"
  type        = string
}

variable "topic_name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "fifo" {
  description = "Enable FIFO topic"
  type        = bool
  default     = false
}

variable "retention_period" {
  description = "Retention period for DLQ in days"
  type        = number
  default     = 5
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO topic"
  type        = bool
  default     = false
}