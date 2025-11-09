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

variable "subscription_id" {
  type    = string
  default = "00000000-0000-0000-0000-000000000000"
}