# resource "azurerm_log_analytics_workspace" "main" {
#   name                = var.log_analytics_workspace_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
#   tags                = var.tags
# }

# resource "azurerm_kubernetes_cluster_extension" "oms_agent" {
#   name                = "omsagent"
#   cluster_id          = var.aks_cluster_id
#   extension_type      = "Microsoft.AzureMonitor.Containers"
#   release_train       = "Stable"
#   version             = "2.8.0"
#   scope               = "cluster"
#   configuration_settings = {
#     "logAnalyticsWorkspaceResourceID" = azurerm_log_analytics_workspace.main.id
#   }
#   tags = var.tags
# }
