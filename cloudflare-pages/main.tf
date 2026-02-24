resource "cloudflare_pages_project" "pages" {
  account_id        = var.account_id
  name              = var.domain_prefix
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

# As described here: https://github.com/cloudflare/terraform-provider-cloudflare/issues/3099
# creating a pages project won't automatically deploy it, so we need to trigger the deployment manually
resource "terraform_data" "trigger_initial_deploy" {
  triggers_replace = [
    cloudflare_pages_project.pages.id
  ]

  provisioner "local-exec" {
    command = <<EOT
      curl -X POST "https://api.cloudflare.com/client/v4/accounts/${var.account_id}/pages/projects/${cloudflare_pages_project.pages.name}/deployments" \
           -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
           -H "Content-Type: application/json" \
           --data '{"branch":"main"}'
    EOT
    environment = {
      CLOUDFLARE_API_TOKEN = var.api_token
    }
  }
}

