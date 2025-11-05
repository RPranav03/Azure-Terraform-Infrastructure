variable "environment" {
  type    = string
  default = "prod"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "deploy_app_service" {
  type    = bool
  default = false
}