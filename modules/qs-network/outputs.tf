output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.dynamic_subnets.public_subnet_ids
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.dynamic_subnets.private_subnet_ids
}

output "no_access_sg_id" {
  description = "ID of the no-access security group"
  value       = module.no_access_sg.id
}

output "http_access_sg_id" {
  description = "ID of the HTTP access security group"
  value       = module.http_access_sg.id
}

output "https_access_sg_id" {
  description = "ID of the HTTPS access security group"
  value       = module.https_access_sg.id
}

output "rds_postgres_access_sg_id" {
  description = "ID of the RDS PostgreSQL access security group"
  value       = module.rds_postgres_access_sg.id
}

output "rds_mysql_access_sg_id" {
  description = "ID of the RDS MySQL access security group"
  value       = module.rds_mysql_access_sg.id
}

output "service_discovery_namespace_name" {
  description = "ID of the service discovery namespace"
  value       = aws_service_discovery_private_dns_namespace.erpconnect_dns_namespace.name
}

output "service_discovery_namespace_id" {
  description = "ID of the service discovery namespace"
  value       = aws_service_discovery_private_dns_namespace.erpconnect_dns_namespace.id
}