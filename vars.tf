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

  description = "기재된 ECR의 이미지 사용여부 (is_enable_ecr_repostiry), 활성화한다면 -> ECR에 이미지를 생성해야 함..."

  default = {
    is_enable                = true
    is_enable_ecr_repository = false
    exists_ecr_name          = ""
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

variable "ecs_extends_policy" {
  description = "ecs 실행역할에 추가될 정책"
  default     = {}
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
