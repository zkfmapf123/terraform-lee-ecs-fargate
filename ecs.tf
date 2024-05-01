########################################## ECR ##########################################
resource "aws_ecr_repository" "ecr" {
  count = lookup(var.is_create_ecr, "is_enable") ? 1 : 0

  name         = "${var.prefix}-svc-ecr"
  force_delete = true

  tags = {
    Name = "${var.prefix}-svc-ecr"
  }
}

########################################## Cluster ##########################################
resource "aws_ecs_cluster" "cluster" {
  count = lookup(var.is_create_cluster, "is_enable") ? 1 : 0

  name = "${var.prefix}-svc-cluster"

  tags = {
    Name = "${var.prefix}-svc-cluster"
  }
}

########################################## ecs-task-def ##########################################
resource "aws_ecs_task_definition" "task_def" {
  family = "${var.prefix}-svc-family"

  cpu    = lookup(var.ecs_attr, "cpu")
  memory = lookup(var.ecs_attr, "memory")

  container_definitions = jsonencode(var.task_def)

  execution_role_arn       = aws_iam_role.role.arn
  task_role_arn            = aws_iam_role.role.arn
  network_mode             = "awsvpc" ## only fargate
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}

########################################## ecs-service ##########################################
resource "aws_ecs_service" "service" {
  launch_type            = "FARGATE"
  name                   = lookup(var.task_def[0], "name")
  cluster                = lookup(var.is_create_cluster, "is_enable") ? aws_ecs_cluster.cluster[0].name : lookup(var.is_create_cluster, "exists_cluster_name")
  task_definition        = aws_ecs_task_definition.task_def.id
  desired_count          = lookup(var.ecs_attr, "desired_count")
  enable_execute_command = true

  network_configuration {
    assign_public_ip = lookup(var.ecs_attr, "is_public")
    subnets          = lookup(var.ecs_attr, "subnet_ids")
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    container_name   = lookup(var.task_def[0], "name")
    container_port   = lookup(var.ecs_attr, "port")
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_iam_role.role]
}
