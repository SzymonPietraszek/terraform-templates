variable "account_id" { type = string }
variable "api_token" { type = string }

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

variable "name_prefix" {
  type    = string
  default = "cloudflare-pages-zero-trust"
}

variable "email" { type = string }
variable "google_client_id" { type = string }
variable "google_client_secret" { type = string }
