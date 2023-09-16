# Create Resource group
resource "azurerm_resource_group" "resource_grp" {
  name     = "sqlrsgp"
  location = "East US"
}


# Create storage account
resource "azurerm_storage_account" "azstorage" {
  name                     	= "sqlstorage7890"
  resource_group_name      	= azurerm_resource_group.resource_grp.name
  location                 	= azurerm_resource_group.resource_grp.location
  account_tier             	= "Standard"
  account_replication_type 	= "LRS"
}
