resource "azurerm_kubernetes_cluster" "main" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  private_cluster_enabled = var.private_cluster_enabled

  default_node_pool {
    name       = "systempool"
    node_count = var.system_node_pool_node_count
    vm_size    = var.system_node_pool_vm_size
    vnet_subnet_id = var.aks_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.0.0.10"
    # docker_bridge_cidr = "172.17.0.1/16" # Deprecated
    service_cidr       = "10.0.0.0/16"
  }

  azure_active_directory_role_based_access_control {
    managed = true
    azure_rbac_enabled = true
    tenant_id          = data.azurerm_client_config.current.tenant_id
    admin_group_object_ids = var.admin_group_object_ids
  }

  azure_policy_enabled = var.azure_policy_enabled

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "user_node_pools" {
  for_each = var.user_node_pools

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  vnet_subnet_id        = var.aks_subnet_id

  enable_auto_scaling = each.value.enable_auto_scaling
  min_count           = each.value.min_count
  max_count           = each.value.max_count

  tags = var.tags
}

data "azurerm_client_config" "current" {}
