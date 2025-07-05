variable "resource_group_name" {
  description = "The name of the resource group for the AKS cluster."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the AKS cluster into."
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network for AKS."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the AKS Virtual Network."
  type        = list(string)
}

variable "aks_subnet_name" {
  description = "The name of the subnet for AKS nodes."
  type        = string
}

variable "aks_subnet_address_prefixes" {
  description = "The address prefixes for the AKS subnet."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}
