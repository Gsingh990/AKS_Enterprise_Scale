resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.aks_subnet_address_prefixes
  service_endpoints    = ["Microsoft.ContainerRegistry", "Microsoft.Storage"]
  # Removed delegation block as AKS manages it internally
}

resource "azurerm_network_security_group" "aks_nsg" {
  name                = "${var.aks_subnet_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "aks_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.aks_subnet.id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}

# NSG Rules for AKS (basic set, customize as needed)
# resource "azurerm_network_security_rule" "allow_aks_control_plane_inbound" {
#   name                        = "Allow-AKS-Control-Plane-Inbound"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "22,9000,10250,10255,443"
#   source_address_prefix       = "AzureCloud" # Use Service Tag instead of *
#   destination_address_prefix  = "*"
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.aks_nsg.name
# }

# # Allow outbound to Azure Container Registry
# resource "azurerm_network_security_rule" "allow_acr_outbound" {
#   name                        = "Allow-ACR-Outbound"
#   priority                    = 110
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "443"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "AzureContainerRegistry" # Use Service Tag
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.aks_nsg.name
# }

# # Allow outbound to Azure Active Directory
# resource "azurerm_network_security_rule" "allow_aad_outbound" {
#   name                        = "Allow-AAD-Outbound"
#   priority                    = 120
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "443"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "AzureActiveDirectory" # Use Service Tag
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.aks_nsg.name
# }

# # Allow outbound to Azure Storage
# resource "azurerm_network_security_rule" "allow_storage_outbound" {
#   name                        = "Allow-Storage-Outbound"
#   priority                    = 130
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "443"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "Storage" # Use Service Tag
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.aks_nsg.name
# }

# # Allow outbound to Internet (for general updates, etc. - consider restricting further in production)
# resource "azurerm_network_security_rule" "allow_internet_outbound" {
#   name                        = "Allow-Internet-Outbound"
#   priority                    = 140
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "0.0.0.0/0" # Use specific CIDR or restrict further
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = azurerm_network_security_group.aks_nsg.name
# }