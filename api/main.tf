module "app_load_balancer" {
  source = "../modules/qs-ecs-apploadbalancer"

  stack_name        = var.stack_name
  vpc_id            = var.vpc_id
  subnet_ids        = var.private_subnet_ids
  internet_facing   = false
  port              = 80
  security_group_id = var.http_security_group_id
  task_name         = var.backend_service
  task_port         = 80
  priority          = 1
}

/*
module "frontend1_target_group" {
  source = "../modules/qs-ecs-apploadbalancer"

  stack_name        = var.stack_name
  vpc_id            = var.vpc_id
  subnet_ids        = var.private_subnet_ids
  internet_facing   = false
  port              = 80
  security_group_id = var.http_security_group_id
  task_name         = var.frontend1_service
  task_port         = 80
  priority          = 2
}

module "frontend2_target_group" {
  source = "../modules/qs-ecs-apploadbalancer"

  stack_name        = var.stack_name
  vpc_id            = var.vpc_id
  subnet_ids        = var.private_subnet_ids
  internet_facing   = false
  port              = 80
  security_group_id = var.http_security_group_id
  task_name         = var.frontend2_service
  task_port         = 80
  priority          = 3
}

*/
module "network_load_balancer" {
  source = "../modules/qs-ecs-networkloadbalancer"

  stack_name               = var.stack_name
  vpc_id                   = var.vpc_id
  subnet_ids               = var.public_subnet_ids
  internet_facing          = true
  port                     = 80
  application_listener_arn = module.app_load_balancer.listener_arn
}

resource "aws_api_gateway_vpc_link" "vpc_link" {
  name        = "${var.stack_name}-vpclink"
  target_arns = [module.network_load_balancer.nlb_arn]

  tags = {
    Name = "${var.stack_name}-vpclink"
  }
}

module "api_gateway" {
  source = "../modules/qs-ecs-apigateway"

  stack_name              = var.stack_name
  api_name                = "FrontEndSpringBootAppServiceApi"
  nlb_dns_name            = module.network_load_balancer.nlb_dns_name
  integration_http_method = "ANY"
  api_key_required        = true
  subnet_ids              = var.public_subnet_ids
  security_group_id       = var.http_security_group_id
}