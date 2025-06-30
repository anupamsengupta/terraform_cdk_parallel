output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "direct_notification_queue_arn" {
  description = "ARN of the notification queue, if created"
  value       = var.event_notification_enabled && !var.eventbridge_enabled ? aws_sqs_queue.direct_notification_queue[0].arn : null
}

output "eventbridge_notification_queue_arn" {
  description = "ARN of the notification queue, if created"
  value       = !var.event_notification_enabled && var.eventbridge_enabled ? aws_sqs_queue.eventbridge_notification_queue[0].arn : null
}
