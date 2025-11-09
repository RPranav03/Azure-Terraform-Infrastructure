variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created."
  type        = string
}

variable "environment" {
  description = "The environment for the virtual network (e.g., dev, prod)."
  type        = string
}

variable "location" {
  description = "The location where the virtual network will be created."
  type        = string
}