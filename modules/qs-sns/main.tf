module "sns_topic" {
  source  = "cloudposse/sns-topic/aws"
  version = "1.2.0"

  name                        = var.topic_name
  fifo_topic                  = var.fifo
  content_based_deduplication = var.content_based_deduplication
  sqs_dlq_enabled             = var.retention_period > 0
  //sqs_dlq_maximum_message_retention_period = var.retention_period * 24 * 60 * 60

  tags = {
    Name = "${var.stack_name}-${var.topic_name}"
  }
}