
# Create a new Azure SQL database under existing Azure SQL Server


data "azurerm_mssql_server" "srvid" {
  name                = "sqlinstvm"
  resource_group_name = "sqlrsgp"
}

# Create Azure SQL database
resource "azurerm_mssql_database" "sql_db" {
  name                 = "dbs3"
  server_id            = data.azurerm_mssql_server.srvid.id
  storage_account_type = "Local"
  geo_backup_enabled   = false
  sku_name             = "Basic"
  max_size_gb          = 1
  tags = {
    environment = "Development"
  }
}