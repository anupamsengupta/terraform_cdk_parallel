

output "cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.main_cluster.arn
}
output "task_execution_role_arn" {
  description = "ARN of the task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "task_role_arn" {
  description = "ARN of the task role"
  value       = aws_iam_role.ecs_task_role.arn
}

/*
output "service_discovery_namespace_id" {
  description = "ID of the service discovery namespace"
  value       = module.service_discovery.namespace_id
}
output "service_discovery_namespace_name" {
  description = "Name of the service discovery namespace"
  value       = module.service_discovery.namespace_name
}
*/
