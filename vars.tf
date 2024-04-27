################################## Common ##################################
variable "prefix" {
  type = string
}

################################## Network ##################################
variable "vpc_attr" {

  default = {
    vpc_id         = ""
    alb_subnet_ids = [""]
  }
}

################################## load balancer ##################################
variable "lb_attr" {
  default = {
    internal             = false
    deregistration_delay = 60
  }
}

variable "lb_health" {
  default = {
    path                = "/health"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}

################################## Container ##################################
variable "ecs_attr" {

  default = {
    port = 3000
  }
}
