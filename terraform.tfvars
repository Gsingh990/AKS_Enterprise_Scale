resource_group_name = "rg-aks-enterprise"
location            = "eastus"

tags = {
  environment = "prod"
  project     = "aks-enterprise"
}

vnet_name = "vnet-aks-enterprise"
vnet_address_space = ["10.20.0.0/16"]
aks_subnet_name = "snet-aks-nodes"
aks_subnet_address_prefixes = ["10.20.1.0/24"]

aks_cluster_name = "aks-enterprise-cluster"
kubernetes_version = "1.30.7"
dns_prefix = "aks-enterprise"
system_node_pool_vm_size = "Standard_D2s_v3"
system_node_pool_node_count = 2

user_node_pools = {
  "default_user_pool" = {
    name          = "userpool1"
    vm_size       = "Standard_D2s_v3"
    node_count    = 1
    enable_auto_scaling = true
    min_count     = 1
    max_count     = 3
  }
  # "gpu_pool" = { # Hashed out due to VMSizeNotSupported error
  #   name          = "gpupool"
  #   vm_size       = "Standard_NC6s_v3"
  #   node_count    = 0
  #   enable_auto_scaling = true
  #   min_count     = 0
  #   max_count     = 2
  # }
}

private_cluster_enabled = true
azure_policy_enabled = true

admin_group_object_ids = [] # Add your Azure AD Group Object IDs here for admin access

# log_analytics_workspace_name = "la-aks-enterprise"