
# Locate resource group
data "azurerm_resource_group" "rsgid" {
  name = "sqlrsgp"
}

# Create a Vnet
resource "azurerm_virtual_network" "mainvnet" {
  name                = "mainvnet"
  location            = data.azurerm_resource_group.rsgid.location
  resource_group_name = data.azurerm_resource_group.rsgid.name
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet_1 under the vnet
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet_1"
  resource_group_name  = data.azurerm_resource_group.rsgid.name
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.mainvnet.name
  depends_on = [
     azurerm_virtual_network.mainvnet
]
}

# Create a subnet_2 under the vnet
resource "azurerm_subnet" "subnet2" {
  name                 = "subnet_2"
  resource_group_name  = data.azurerm_resource_group.rsgid.name
  address_prefixes     = ["10.0.2.0/24"]
  virtual_network_name = azurerm_virtual_network.mainvnet.name
  depends_on = [
     azurerm_virtual_network.mainvnet
]
}
