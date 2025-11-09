variable "resource_group_name" {
  description = "The name of the resource group where the virtual networks are located."
  type        = string
}

variable "hub_vnet_name" {
  description = "The name of the hub virtual network."
  type        = string
}

variable "hub_vnet_id" {
  description = "The ID of the hub virtual network."
  type        = string
}

variable "spoke_vnet_name" {
  description = "The name of the spoke virtual network."
  type        = string
}

variable "spoke_vnet_id" {
  description = "The ID of the spoke virtual network."
  type        = string
}