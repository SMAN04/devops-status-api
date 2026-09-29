resource "aws_ecr_repository" "app" {
  name         = "devops-status-api"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "devops-status-api"
  }
}