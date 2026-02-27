variable "account_id" { type = string }
variable "api_token" { type = string }
variable "email" { type = string }
variable "google_client_id" { type = string }
variable "google_client_secret" { type = string }

variable "domain_prefix" {
  type    = string
  default = "szymon"
}

variable "github_owner" {
  type    = string
  default = "SzymonPietraszek"
}

variable "github_repo" {
  type    = string
  default = "cloudflare-pages-example"
}

variable "github_branch" {
  type    = string
  default = "main"
}
