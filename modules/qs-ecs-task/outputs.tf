

output "service_arn" {
  description = "ARN of the ECS service"
  value       = module.ecs_service.service_arn
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs_task.task_definition_arn
}
