output "service_arn" {
  description = "ARN of the ECS service"
  value       = module.ecs_task.service_arn
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs_task.task_definition_arn
}

output "task_name" {
  description = "Name of the backend task"
  value       = var.context_path
}