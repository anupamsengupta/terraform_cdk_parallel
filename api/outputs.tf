output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.app_load_balancer.alb_arn
}

output "nlb_arn" {
  description = "ARN of the Network Load Balancer"
  value       = module.network_load_balancer.nlb_arn
}

output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = module.network_load_balancer.nlb_dns_name
}

output "api_gateway_id" {
  description = "ID of the API Gateway"
  value       = module.api_gateway.rest_api_id
}