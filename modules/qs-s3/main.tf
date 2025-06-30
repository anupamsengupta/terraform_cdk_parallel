module "s3_bucket" {
  source  = "cloudposse/s3-bucket/aws"
  version = "4.2.0"

  bucket_name             = var.bucket_name
  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access
  force_destroy           = var.removal_policy == "DESTROY" ? true : false
  //sse_algorithm                 = var.sse_algorithm
  versioning_enabled            = var.versioned
  lifecycle_configuration_rules = local.lifecycle_configuration_rules

  name = "${var.stack_name}-${var.bucket_name}"

  tags = {
    Name = "${var.stack_name}-${var.bucket_name}"
  }
}

# SQS Queue for notifications if direct queue notification enabled
resource "aws_sqs_queue" "direct_notification_queue" {
  count      = var.event_notification_enabled && !var.eventbridge_enabled ? 1 : 0
  depends_on = [module.s3_bucket]

  name                       = "direct-${var.notification_queue_name}"
  visibility_timeout_seconds = var.notification_queue_visibility_timeout
  message_retention_seconds  = var.notification_queue_retention_period * 24 * 60 * 60

  tags = {
    Name = "${var.stack_name}-${var.bucket_name}-notifications"
  }
}

# SQS Queue for notifications if eventbridge queue notification  enabled
resource "aws_sqs_queue" "eventbridge_notification_queue" {
  count      = !var.event_notification_enabled && var.eventbridge_enabled ? 1 : 0
  depends_on = [module.s3_bucket]

  name                       = "eventbridge-${var.notification_queue_name}"
  visibility_timeout_seconds = var.notification_queue_visibility_timeout
  message_retention_seconds  = var.notification_queue_retention_period * 24 * 60 * 60

  tags = {
    Name = "${var.stack_name}-${var.bucket_name}-notifications"
  }
}

#enable eventbridge is flagged true
resource "aws_s3_bucket_notification" "eventbridge_bucket_notification" {
  count = var.eventbridge_enabled ? 1 : 0

  depends_on  = [module.s3_bucket]
  bucket      = module.s3_bucket.bucket_id
  eventbridge = true
}


# EventBridge Rule for S3 Events
resource "aws_cloudwatch_event_rule" "s3_event_rule" {
  count = var.eventbridge_enabled ? 1 : 0

  depends_on  = [module.s3_bucket, aws_sqs_queue.eventbridge_notification_queue]
  name        = "${var.bucket_name}-s3-event-rule"
  description = "Capture S3 Object Created and Removed events"
  event_pattern = jsonencode({
    source      = ["aws.s3"]
    detail_type = ["Object Created", "Object Removed"]
    detail = {
      bucket = {
        name = [module.s3_bucket.bucket_id]
      }
    }
  })
}

# EventBridge Target for S3 Events
resource "aws_cloudwatch_event_target" "s3_event_target" {
  count = var.eventbridge_enabled ? 1 : 0

  depends_on = [module.s3_bucket, aws_sqs_queue.eventbridge_notification_queue]
  rule       = aws_cloudwatch_event_rule.s3_event_rule[0].name
  target_id  = "${var.bucket_name}-s3-event-target"
  arn        = aws_sqs_queue.eventbridge_notification_queue[0].arn
}

# SQS Queue Policy for EventBridge
resource "aws_sqs_queue_policy" "eventbridge_notification_queue_policy" {
  count = var.eventbridge_enabled ? 1 : 0

  depends_on = [aws_sqs_queue.eventbridge_notification_queue]
  queue_url  = aws_sqs_queue.eventbridge_notification_queue[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "events.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.eventbridge_notification_queue[0].arn
      },
      {
        Effect    = "Allow"
        Principal = { Service = "events.amazonaws.com" }
        Action    = ["sqs:GetQueueAttributes", "sqs:GetQueueUrl", "sqs:SendMessage"]
        Resource  = aws_sqs_queue.eventbridge_notification_queue[0].arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = "arn:aws:events:${var.region}:${data.aws_caller_identity.current.account_id}:rule/${aws_cloudwatch_event_rule.s3_event_rule[0].name}"
          }
        }
      }
    ]
  })
}

# SQS Queue Policy for notification
resource "aws_sqs_queue_policy" "directsqs_notification_queue_policy" {
  count = var.event_notification_enabled ? 1 : 0

  depends_on = [aws_sqs_queue.direct_notification_queue]
  queue_url  = aws_sqs_queue.direct_notification_queue[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.direct_notification_queue[0].arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = module.s3_bucket.bucket_arn
          }
        }
      }
    ]
  })
}

# S3 Event Notification to SQS
resource "aws_s3_bucket_notification" "direct_bucket_notification" {
  count      = var.event_notification_enabled && !var.eventbridge_enabled ? 1 : 0
  depends_on = [aws_sqs_queue.direct_notification_queue, aws_sqs_queue_policy.directsqs_notification_queue_policy]
  bucket     = module.s3_bucket.bucket_id
  queue {
    queue_arn     = aws_sqs_queue.direct_notification_queue[0].arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = var.filter_prefix
    filter_suffix = var.filter_suffix
  }
}
