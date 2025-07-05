resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "aks_networking" {
  source = "./modules/aks_networking"

  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  aks_subnet_name     = var.aks_subnet_name
  aks_subnet_address_prefixes = var.aks_subnet_address_prefixes
  tags                = var.tags
}

module "aks_cluster" {
  source = "./modules/aks_cluster"

  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  aks_cluster_name    = var.aks_cluster_name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = var.dns_prefix
  aks_subnet_id       = module.aks_networking.aks_subnet_id
  system_node_pool_vm_size = var.system_node_pool_vm_size
  system_node_pool_node_count = var.system_node_pool_node_count
  user_node_pools     = var.user_node_pools
  private_cluster_enabled = var.private_cluster_enabled
  azure_policy_enabled = var.azure_policy_enabled
  admin_group_object_ids = var.admin_group_object_ids
  tags                = var.tags
}

# module "aks_monitoring" {
#   source = "./modules/aks_monitoring"

#   resource_group_name = azurerm_resource_group.aks_rg.name
#   location            = azurerm_resource_group.aks_rg.location
#   log_analytics_workspace_name = var.log_analytics_workspace_name
#   aks_cluster_id      = module.aks_cluster.aks_cluster_id
#   tags                = var.tags
# }