output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.notification_queue.arn
}

output "queue_id" {
  description = "ID of the SQS queue"
  value       = aws_sqs_queue.notification_queue.id
}

output "notification_queue" {
  description = "exported SQS queue"
  value       = aws_sqs_queue.notification_queue
}
