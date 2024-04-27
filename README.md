<!-- BEGIN_TF_DOCS -->
## Requirements

ECS-Fargate Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.task_def](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.role_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.listener_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.alb_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecs_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy.ecs_task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_attr"></a> [ecs\_attr](#input\_ecs\_attr) | n/a | `map` | <pre>{<br>  "cpu": 256,<br>  "desired_count": 1,<br>  "memory": 512,<br>  "port": 3000,<br>  "subnet_ids": []<br>}</pre> | no |
| <a name="input_is_create_cluster"></a> [is\_create\_cluster](#input\_is\_create\_cluster) | n/a | `map` | <pre>{<br>  "exists_cluster_name": "",<br>  "is_enable": true<br>}</pre> | no |
| <a name="input_is_create_ecr"></a> [is\_create\_ecr](#input\_is\_create\_ecr) | ################################# Container ################################## | `map` | <pre>{<br>  "exists_ecr_name": "",<br>  "is_enable": true<br>}</pre> | no |
| <a name="input_lb_attr"></a> [lb\_attr](#input\_lb\_attr) | ################################# load balancer ################################## | `map` | <pre>{<br>  "deregistration_delay": 60,<br>  "internal": false<br>}</pre> | no |
| <a name="input_lb_health"></a> [lb\_health](#input\_lb\_health) | n/a | `map` | <pre>{<br>  "healthy_threshold": 2,<br>  "interval": 30,<br>  "path": "/health",<br>  "protocol": "HTTP",<br>  "timeout": 5,<br>  "unhealthy_threshold": 2<br>}</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | ################################# Common ################################## | `string` | n/a | yes |
| <a name="input_task_def"></a> [task\_def](#input\_task\_def) | n/a | `map` | <pre>{<br>  "cpu": 256,<br>  "environment": [<br>    {<br>      "name": "PORT",<br>      "value": "3000"<br>    }<br>  ],<br>  "essential": true,<br>  "image": "zkfmapf123/donggyu-friends:2.0",<br>  "logConfiguration": {<br>    "logDriver": "awslogs",<br>    "options": {<br>      "awslogs-create-group": "true",<br>      "awslogs-group": "server-container",<br>      "awslogs-region": "ap-northeast-2",<br>      "awslogs-stream-prefix": "ecs"<br>    }<br>  },<br>  "memory": 512,<br>  "name": "ecs-server-container",<br>  "portMappings": [<br>    {<br>      "containerPort": 3000,<br>      "hostPort": 3000,<br>      "protocol": "tcp"<br>    }<br>  ]<br>}</pre> | no |
| <a name="input_vpc_attr"></a> [vpc\_attr](#input\_vpc\_attr) | ################################# Network ################################## | `map` | <pre>{<br>  "alb_subnet_ids": [<br>    ""<br>  ],<br>  "vpc_id": ""<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->