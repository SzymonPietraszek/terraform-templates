variable "account_id" { type = string }
variable "api_token" { type = string }

variable "github_owner" {
  type    = string
  default = "SzymonPietraszek"
}

variable "github_repo" {
  type    = string
  default = "cloudflare-pages-example"
}
