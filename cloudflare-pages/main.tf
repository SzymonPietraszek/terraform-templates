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

resource "cloudflare_pages_project" "pages" {
  account_id        = var.account_id
  name              = "my-pages-app"
  production_branch = "main"

  build_config = {
    build_command   = "npm run build"
    destination_dir = "dist"
  }

  source = {
    config = {
      production_deployments_enabled = true
      owner                          = var.github_owner
      production_branch              = "main"
      repo_name                      = var.github_repo
    }
    type = "github"
  }
}

output "url" {
  value = "https://${cloudflare_pages_project.pages.subdomain}"
}
