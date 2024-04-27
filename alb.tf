######################################## ALB ########################################
resource "aws_lb" "alb" {
  name               = "${var.prefix}-svc-alb"
  internal           = lookup(var.lb_attr, "internal")
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = lookup(var.vpc_attr, "alb_subnet_ids")

  enable_deletion_protection = false

  tags = {
    Name = "${var.prefix}-svc-alb"
  }
}

######################################## Target Group ########################################
resource "aws_lb_target_group" "alb_tg" {
  name                 = "${var.prefix}-svc-tg"
  port                 = lookup(var.ecs_attr, "port")
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = lookup(var.vpc_attr, "vpc_id")
  deregistration_delay = lookup(var.lb_attr, "deregistration_delay")

  health_check {
    path                = lookup(var.lb_health, "path")
    protocol            = lookup(var.lb_health, "protocol")
    port                = lookup(var.ecs_attr, "port")
    interval            = lookup(var.lb_health, "interval")
    timeout             = lookup(var.lb_health, "timeout")
    unhealthy_threshold = lookup(var.lb_health, "unhealthy_threshold")
    healthy_threshold   = lookup(var.lb_health, "healthy_threshold")
  }
}

######################################## Listener ########################################
resource "aws_lb_listener" "listener_80" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}
