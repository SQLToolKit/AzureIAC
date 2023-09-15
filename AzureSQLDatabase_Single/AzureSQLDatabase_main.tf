# Create Resource group
resource "azurerm_resource_group" "resource_grp" {
  name     = "SQLLab"
  location = "East US"
}



# Define Azure SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = "sqlinst"
  resource_group_name          = azurerm_resource_group.resource_grp.name
  location                     = azurerm_resource_group.resource_grp.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Apple.121"
}



# Create Azure SQL database
resource "azurerm_mssql_database" "sql_db" {
  name = "dbs1"
  #resource_group_name 	= azurerm_resource_group.resource_grp.name
  #location            	= azurerm_resource_group.resource_grp.location
  server_id            = azurerm_mssql_server.sql_server.id
  storage_account_type = "Local"
  geo_backup_enabled   = false
  sku_name             = "Basic"
  max_size_gb          = 1

  depends_on = [
    azurerm_mssql_server.sql_server
  ]
}



# For access through internet for client machine
resource "azurerm_mssql_firewall_rule" "sql_firewall_rule" {
  name             = "sql_firewall_rule"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "99.234.221.26"
  end_ip_address   = "99.234.221.26"

  depends_on = [
    azurerm_mssql_server.sql_server
  ]
}



# For access to Azure Services
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"

  depends_on = [
    azurerm_mssql_server.sql_server
  ]
}

