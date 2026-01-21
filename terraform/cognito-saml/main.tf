terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
}

resource "aws_cognito_identity_provider" "simplesaml" {
  user_pool_id  = var.user_pool_id
  provider_name = "SimpleSAML"
  provider_type = "SAML"

  provider_details = {
    MetadataFile = file("${path.module}/idp-metadata.xml")
  }

  attribute_mapping = {
    email = "email"
    name  = "displayName"
    given_name = "givenName"
    family_name = "sn"
  }
}


resource "aws_cognito_user_pool_client" "saml_app_client" {
  depends_on = [
    aws_cognito_identity_provider.simplesaml
  ]

  name         = "saml-federated-app"
  user_pool_id = var.user_pool_id

  supported_identity_providers = [
    "SimpleSAML"
  ]

  allowed_oauth_flows = [
    "code"
  ]

  allowed_oauth_scopes = [
    "email",
    "openid",
    "profile"
  ]

  allowed_oauth_flows_user_pool_client = true

  callback_urls = var.app_callback_urls
  logout_urls   = var.app_logout_urls

  generate_secret = true
}


