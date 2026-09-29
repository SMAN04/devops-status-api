resource "aws_security_group" "alb" {
  name        = "devops-status-alb-sg"
  description = "Secuirty group for Devops Status API ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP traffic from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-status-alb-sg"
  }
}

resource "aws_security_group" "ecs" {
  name        = "devops-status-ecs-sg"
  description = "secuirty group for DevOps status API ECS tasks"
  vpc_id      = aws_vpc.main.id


  ingress {
    description     = "Allow traffic from ALB"
    from_port       = 8000
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-status-ecs-sg"
  }

}