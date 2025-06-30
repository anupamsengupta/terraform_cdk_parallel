module "test_queue" {
  source = "../modules/qs-sqs"

  context                    = var.context
  stack_name                 = var.stack_name
  queue_name                 = "${var.stack_name}-com-quickysoft-anu-testqueue"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  enable_dlq                 = var.enable_dlq
}

module "test_topic" {
  source = "../modules/qs-sns"

  context    = var.context
  stack_name = var.stack_name
  topic_name = "${var.stack_name}-com-quickysoft-anu-testtopic"
}

# This module sets up an S3 bucket with direct event notifications.
module "s3_event_notification" {
  source = "../modules/qs-s3"

  context                            = var.context
  region                             = var.region
  stack_name                         = var.stack_name
  bucket_name                        = "${var.stack_name}-com-quickysoft-anu-eventnotification-bucket"
  event_notification_enabled         = var.event_notification_enabled
  eventbridge_enabled                = false
  notification_queue_name            = var.notification_queue_name
  versioned                          = var.versioned
  filter_prefix                      = var.filter_prefix
  filter_suffix                      = var.filter_suffix
  object_expiration_days             = var.object_expiration_days
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  object_transition_standardia_days  = var.object_transition_standardia_days
  object_transition_onezoneia_days   = var.object_transition_onezoneia_days
}

//need to move on, somehow teh event bridge is not workignf with all permissions at place
//to be looked at later
# This module sets up an S3 bucket with EventBridge notifications enabled.
module "s3_eventbridge" {
  source = "../modules/qs-s3"

  context                            = var.context
  region                             = var.region
  stack_name                         = var.stack_name
  bucket_name                        = "${var.stack_name}-com-quickysoft-anu-eventbridge-bucket"
  event_notification_enabled         = false
  eventbridge_enabled                = var.eventbridge_enabled
  notification_queue_name            = var.notification_queue_name
  versioned                          = var.versioned
  filter_prefix                      = var.filter_prefix
  filter_suffix                      = var.filter_suffix
  object_expiration_days             = var.object_expiration_days
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  object_transition_standardia_days  = var.object_transition_standardia_days
  object_transition_onezoneia_days   = var.object_transition_onezoneia_days
}
