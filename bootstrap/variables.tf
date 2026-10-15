variable "aws_region" {
  description = "AWS region for bootstrap resources"
  type        = string
  default     = "eu-north-1"
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
}