output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "listener_arn" {
  description = "ARN of the ALB listener"
  value       = module.alb.http_listener_arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = var.task_name != "" ? aws_lb_target_group.ecs_target[0].arn : null
}