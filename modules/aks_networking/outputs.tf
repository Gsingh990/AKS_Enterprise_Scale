output "vnet_id" {
  description = "The ID of the AKS Virtual Network."
  value       = azurerm_virtual_network.main.id
}

output "aks_subnet_id" {
  description = "The ID of the AKS subnet."
  value       = azurerm_subnet.aks_subnet.id
}

output "aks_nsg_id" {
  description = "The ID of the AKS Network Security Group."
  value       = azurerm_network_security_group.aks_nsg.id
}
