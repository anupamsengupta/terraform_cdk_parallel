resource "aws_sqs_queue" "notification_queue" {

  name                       = var.queue_name
  depends_on = [ aws_sqs_queue.dlq ]
  delay_seconds              = var.delivery_delay_seconds
  max_message_size           = var.max_message_size_bytes
  message_retention_seconds  = var.retention_period_days * 24 * 60 * 60
  receive_wait_time_seconds  = var.receive_message_wait_time_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds

  redrive_policy = var.enable_dlq ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  tags = {
    Name = "${var.stack_name}-${var.queue_name}"
  }
}

resource "aws_sqs_queue" "dlq" {
  count = var.enable_dlq ? 1 : 0

  name                      = "${var.queue_name}-dlq"
  message_retention_seconds = 14 * 24 * 60 * 60 # 14 days

  tags = {
    Name = "${var.stack_name}-${var.queue_name}-dlq"
  }
}