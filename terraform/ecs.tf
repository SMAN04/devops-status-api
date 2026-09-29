resource "aws_ecs_cluster" "main" {
  name = "devops-status-cluster"

  tags = {
    Name = "devops-status-cluster"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "devops-status-api"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "devops-status-api"
      image     = "${aws_ecr_repository.app.repository_url}:v2"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "devops-status-api-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id
    ]

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = true

  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "devops-status-api"
    container_port   = 8080
  }

  depends_on = [
    aws_lb_listener.http
  ]
}