output "nlb_arn" {
  description = "ARN of the Network Load Balancer"
  value       = module.nlb.nlb_arn
}

output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = module.nlb.nlb_dns_name
}