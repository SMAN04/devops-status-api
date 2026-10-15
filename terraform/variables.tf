variable "aws_region" {
  description = "AWS region for application infrastructure"
  type        = string
  default     = "eu-north-1"
}

variable "image_tag" {
  description = "Docker image tag to deply to ECS"
  type        = string
  default     = "v2"
}

variable "state_bucket_name" {
  description = "S3 bucket used for Terraform remote state"
  type        = string
}