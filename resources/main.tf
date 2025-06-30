module "test_queue" {
  source = "../modules/qs-sqs"

  stack_name                 = var.stack_name
  queue_name                 = "${var.stack_name}-com-quickysoft-anu-testqueue"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  enable_dlq                 = var.enable_dlq
}

module "test_topic" {
  source = "../modules/qs-sns"

  stack_name = var.stack_name
  topic_name = "${var.stack_name}-com-quickysoft-anu-testtopic"
}

module "s3_event_notification" {
  source = "../modules/qs-s3"

  stack_name                 = var.stack_name
  bucket_name                = "${var.stack_name}-com-quickysoft-anu-eventnotification-bucket"
  event_notification_enabled = var.event_notification_enabled
  eventbridge_enabled        = false
  notification_queue_name    = var.notification_queue_name
  versioned                  = var.versioned
  filter_prefix              = var.filter_prefix
  filter_suffix              = var.filter_suffix
}
/*
module "s3_eventbridge" {
  source = "../modules/qs-s3"

  stack_name                 = var.stack_name
  bucket_name                = "${var.stack_name}-com-quickysoft-anu-eventbridge-bucket"
  event_notification_enabled = false
  eventbridge_enabled        = var.eventbridge_enabled
  notification_queue_name    = var.notification_queue_name
  versioned                  = var.versioned
}
*/