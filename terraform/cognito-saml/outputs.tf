output "app_client_id" {
  value = aws_cognito_user_pool_client.saml_app_client.id
}

output "app_client_secret" {
  value     = aws_cognito_user_pool_client.saml_app_client.client_secret
  sensitive = true
}
