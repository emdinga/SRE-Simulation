variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "user_pool_id" {
  description = "Existing Cognito User Pool ID"
  type        = string
}

variable "app_callback_urls" {
  description = "OAuth callback URLs"
  type        = list(string)
}

variable "app_logout_urls" {
  description = "Logout URLs"
  type        = list(string)
}
