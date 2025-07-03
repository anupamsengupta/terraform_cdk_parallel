module "nlb" {
  source  = "cloudposse/nlb/aws"
  version = "0.18.2"

  name                              = "${var.stack_name}-nlb"
  vpc_id                            = var.vpc_id
  subnet_ids                        = var.subnet_ids
  internal                          = !var.internet_facing
  tcp_enabled                       = true
  access_logs_s3_bucket_enabled     = false
  cross_zone_load_balancing_enabled = true

  # Listener configuration
  nlb_config = [
    {
      port     = var.port
      protocol = "TCP"
      target_group = {
        port        = var.port
        protocol    = "TCP"
        target_type = "alb"
        health_check = {
          enabled             = true
          interval            = var.health_check_interval
          timeout             = var.timeout
          unhealthy_threshold = var.unhealthy_threshold_count
          healthy_threshold   = 3
          path                = "/"
        }
        attributes = {
          deregistration_delay = 30
        }
        target_arn = var.application_listener_arn
      }
    }
  ]

  tags = {
    Name = "${var.stack_name}-nlb"
  }
}