
# Locate the existing resource group
data "azurerm_resource_group" "rsgrp" {
  name = "sqlrsgp"
}

# Create storage account
resource "azurerm_storage_account" "azstorage" {
  name                     = "azstorage7890" # Choose unique name
  resource_group_name      = "${data.azurerm_resource_group.rsgrp.name}"
  location                 = "${data.azurerm_resource_group.rsgrp.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "Storage for Database backups"
  }
}

# Create container inside the storage account
resource "azurerm_storage_container" "azcontainer" {
  name                  = "sqlbackups"
  storage_account_name  = "${azurerm_storage_account.azstorage.name}"
  container_access_type = "private"
  depends_on = [
    azurerm_storage_account.azstorage
  ]
}

/*
# Copy some files in the container
resource "azurerm_storage_blob" "azblob" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.azstorage.name
  storage_container_name = azurerm_storage_container.azcontainer.name
  type                   = "Block"
  source                 = "some-local-file.zip"
  depends_on = [
    azurerm_storage_container.azcontainer
  ]
}
*/