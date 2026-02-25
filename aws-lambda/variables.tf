variable "project" {
  type    = string
  default = "lambda"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "github_owner" {
  type    = string
  default = "SzymonPietraszek"
}

variable "github_repo" {
  type    = string
  default = "lambda-fastapi"
}

variable "github_branch" {
  type    = string
  default = "dynamodb"
}

variable "mangun_handler_path" {
  type    = string
  default = "app.main.handler"
}

variable "python_version" {
  type    = string
  default = "3.14"
}
