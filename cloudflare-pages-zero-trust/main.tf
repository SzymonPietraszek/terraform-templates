terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.17.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}

module "page" {
  source = "../cloudflare-pages"

  account_id    = var.account_id
  api_token     = var.api_token
  domain_prefix = var.domain_prefix
  github_owner  = var.github_owner
  github_repo   = var.github_repo
}

resource "cloudflare_zero_trust_access_identity_provider" "google" {
  config = {
    client_id     = var.google_client_id
    client_secret = var.google_client_secret
  }
  name       = "${var.name_prefix}-google"
  type       = "google"
  account_id = var.account_id
}

resource "cloudflare_zero_trust_access_policy" "policy" {
  account_id = var.account_id
  decision   = "allow"
  name       = "${var.name_prefix}-policy"

  include = [{
    email = {
      email = "${var.email}"
    }
  }]
}

resource "cloudflare_zero_trust_access_application" "access" {
  account_id       = var.account_id
  name             = "${var.name_prefix}-access"
  domain           = module.page.subdomain
  session_duration = "24h"
  type             = "self_hosted"
  allowed_idps     = [cloudflare_zero_trust_access_identity_provider.google.id]
  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.policy.id
      precedence = 1
    }
  ]
}
