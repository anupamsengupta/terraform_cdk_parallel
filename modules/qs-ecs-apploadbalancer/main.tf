module "alb" {
  source  = "cloudposse/alb/aws"
  version = "1.12.0"

  name                              = "${var.stack_name}-alb"
  vpc_id                            = var.vpc_id
  subnet_ids                        = var.private_subnet_ids
  internal                          = !var.internet_facing
  security_group_ids                = [var.security_group_id]
  http_enabled                      = true
  http_port                         = var.port
  cross_zone_load_balancing_enabled       = true
  stickiness = false
  access_logs_enabled = true
  access_logs_s3_bucket_id     = false
  access_logs_prefix = true

  http_listener_rules = [
    {
      actions = [
        {
          type = "fixed-response"
          fixed_response = {
            content_type = "text/plain"
            message_body = "{status:\"up\"}"
            status_code  = "200"
          }
        }
      ]
      conditions = []
    }
  ]

  tags = {
    Name = "${var.stack_name}-alb"
  }
}

resource "aws_lb_target_group" "ecs_target" {
  for_each = var.services_list

  name        = "${var.stack_name}-${var.task_name}-tg"
  port        = var.task_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = var.health_check_interval
    timeout             = var.timeout
    unhealthy_threshold = var.unhealthy_threshold_count
    healthy_threshold   = 3
    path                = "/${var.task_name}/actuator/health"
  }

  tags = {
    Name = "${var.stack_name}-${var.task_name}-tg"
  }
}

resource "aws_lb_listener_rule" "ecs_rule" {
  count = var.task_name != "" ? 1 : 0

  listener_arn = module.alb.http_listener_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target[0].arn
  }

  condition {
    path_pattern {
      values = ["/${var.task_name}/*"]
    }
  }
}