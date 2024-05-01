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
variable "is_create_ecr" {
  default = {
    is_enable       = true
    exists_ecr_name = ""
  }
}

variable "is_create_cluster" {
  default = {
    is_enable           = true
    exists_cluster_name = ""
  }
}

variable "ecs_attr" {

  default = {
    port          = 3000
    cpu           = 256
    memory        = 512
    desired_count = 1
    is_public     = false
    subnet_ids    = []
  }
}

variable "task_def" {
  default = {
    name      = "ecs-server-container"
    image     = "zkfmapf123/donggyu-friends:2.0"
    cpu       = 256
    memory    = 512
    essential = true,

    environment = [
      {
        name  = "PORT",
        value = "3000"
      }
    ],
    portMappings = [
      {
        containerPort = 3000
        hostPort      = 3000
        protocol      = "tcp"
      },
    ],
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "server-container"
        awslogs-create-group  = "true"
        awslogs-region        = "ap-northeast-2"
        awslogs-stream-prefix = "ecs"
      }
    }
  }
}
