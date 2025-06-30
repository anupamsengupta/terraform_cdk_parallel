
#general
region     = "us-east-1"
stack_name = "qs-example"
vpc_cidr   = "10.101.0.0/16"
azs        = ["us-east-1a", "us-east-1b"]
vpc_cidrs  = ["10.101.0.0/16"]

#resources
test_queue_name                    = "qs-example-test-queue"
notification_queue_name            = "qs-example-notification-queue"
eventbridge_enabled                = true
event_notification_enabled         = true
versioned                          = true
enable_dlq                         = true
visibility_timeout_seconds         = 900 # 15 minutes
filter_prefix                      = "upload/"
filter_suffix                      = ".csv"
object_expiration_days             = 120
noncurrent_version_expiration_days = 120
object_transition_standardia_days  = 30
object_transition_onezoneia_days   = 60

#application
service_discovery_namespace = "erpconnect.local"
service_cluster_name        = "svcCluster"
backend_ecr_repository_url  = "870912676422.dkr.ecr.us-east-1.amazonaws.com/quickysoft/sample-spring-boot-app"
backend_context_path        = "backend"
frontend1_context_path      = "frontend1"
frontend2_context_path      = "frontend2"
frontend_ecr_repository_url = "870912676422.dkr.ecr.us-east-1.amazonaws.com/quickysoft/sample-spring-boot-app"
environment_vars            = {}

