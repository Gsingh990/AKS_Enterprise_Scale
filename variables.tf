variable "resource_group_name" {
  description = "The name of the resource group for the AKS cluster."
  type        = string
  default     = "rg-aks-enterprise"
}

variable "location" {
  description = "The Azure region to deploy the AKS cluster into."
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  type        = map(string)
  default     = {
    environment = "prod"
    project     = "aks-enterprise"
  }
}

variable "vnet_name" {
  description = "The name of the Virtual Network for AKS."
  type        = string
  default     = "vnet-aks-enterprise"
}

variable "vnet_address_space" {
  description = "The address space for the AKS Virtual Network."
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "aks_subnet_name" {
  description = "The name of the subnet for AKS nodes."
  type        = string
  default     = "snet-aks-nodes"
}

variable "aks_subnet_address_prefixes" {
  description = "The address prefixes for the AKS subnet."
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "aks-enterprise-cluster"
}

variable "kubernetes_version" {
  description = "The Kubernetes version to use for the AKS cluster."
  type        = string
  default     = "1.30.7"
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
  default     = "aks-enterprise"
}

variable "system_node_pool_vm_size" {
  description = "The VM size for the system node pool."
  type        = string
  default     = "Standard_D2s_v3" # Updated VM size
}

variable "system_node_pool_node_count" {
  description = "The initial node count for the system node pool."
  type        = number
  default     = 2
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
  default = {
    "default_user_pool" = {
      name          = "userpool1"
      vm_size       = "Standard_D2s_v3" # Updated VM size
      node_count    = 1
      enable_auto_scaling = true
      min_count     = 1
      max_count     = 3
    }
  }
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

# variable "log_analytics_workspace_name" {
#   description = "The name of the Log Analytics Workspace for AKS monitoring."
#   type        = string
#   default     = "la-aks-enterprise"
# }