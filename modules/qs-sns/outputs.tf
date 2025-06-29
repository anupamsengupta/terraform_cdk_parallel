output "topic_arn" {
  description = "ARN of the SNS topic"
  value       = module.sns_topic.sns_topic_arn
}