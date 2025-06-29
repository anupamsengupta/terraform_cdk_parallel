output "test_queue_arn" {
  description = "ARN of the test SQS queue"
  value       = module.test_queue.queue_arn
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic"
  value       = module.sns_topic.topic_arn
}

output "s3_event_notification_bucket_id" {
  description = "ID of the S3 bucket with event notification"
  value       = module.s3_event_notification.bucket_id
}

output "s3_eventbridge_bucket_id" {
  description = "ID of the S3 bucket with EventBridge"
  value       = module.s3_eventbridge.bucket_id
}