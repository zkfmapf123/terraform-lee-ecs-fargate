resource "aws_security_group" "alb_sg" {
  name        = "${var.prefix}-alb-sg"
  description = "${var.prefix}-alb-sg"
  vpc_id      = lookup(var.vpc_attr, "vpc_id")

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-alb-sg"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.prefix}-ecs-sg"
  description = "${var.prefix}-ecs-sg"
  vpc_id      = lookup(var.vpc_attr, "vpc_id")

  ingress {
    from_port = lookup(var.ecs_attr, "port")
    to_port   = lookup(var.ecs_attr, "port")
    protocol  = "tcp"
    # security_groups = [aws_security_group.alb_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # security_groups = [aws_security_group.alb_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-alb-sg"
  }

  depends_on = [aws_security_group.alb_sg]
}
