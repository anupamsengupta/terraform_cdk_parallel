output "vpc_id" {
  description = "ID of the VPC"
  value       = module.qs_network.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.qs_network.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.qs_network.private_subnets
}

/*
output "s3_bucket_id" {
  description = "ID of the S3 bucket"
  value       = module.qs_s3.bucket_id
}

output "rds_endpoint" {
  description = "RDS Endpoint Address"
  value       = module.qs_rds_postgres.rds_endpoint
}

output "sqs_queue_arn" {
  description = "ARN of the SQS queue"
  value       = module.qs_sqs.queue_arn
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic"
  value       = module.qs_sns.topic_arn
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.qs_ecs_cluster.cluster_arn
}

output "nlb_arn" {
  description = "ARN of the Network Load Balancer"
  value       = module.qs_ecs_networkloadbalancer.nlb_arn
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.qs_ecs_apploadbalancer.alb_arn
}

output "api_gateway_id" {
  description = "ID of the API Gateway"
  value       = module.qs_ecs_apigateway.rest_api_id
}

output "ecs_service_arn" {
  description = "ARN of the ECS service"
  value       = module.qs_ecs_task.service_arn
}
*/