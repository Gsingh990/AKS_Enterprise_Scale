output "aks_cluster_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.id
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.name
}

output "kube_config_raw" {
  description = "Raw Kubernetes config to connect to the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive   = true
}
