variable "resource_group_name" {
  description = "The name of the resource group for the AKS cluster."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the AKS cluster into."
  type        = string
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version to use for the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
}

variable "aks_subnet_id" {
  description = "The ID of the AKS subnet."
  type        = string
}

variable "system_node_pool_vm_size" {
  description = "The VM size for the system node pool."
  type        = string
}

variable "system_node_pool_node_count" {
  description = "The initial node count for the system node pool."
  type        = number
}

variable "user_node_pools" {
  description = "A map of user node pool configurations."
  type = map(object({
    name          = string
    vm_size       = string
    node_count    = number
    enable_auto_scaling = bool
    min_count     = number
    max_count     = number
  }))
}

variable "private_cluster_enabled" {
  description = "Enable private cluster for AKS."
  type        = bool
  default     = true
}

variable "azure_policy_enabled" {
  description = "Enable Azure Policy Add-on for AKS."
  type        = bool
  default     = true
}

variable "admin_group_object_ids" {
  description = "A list of Azure AD Group Object IDs that should have admin access to the cluster."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}