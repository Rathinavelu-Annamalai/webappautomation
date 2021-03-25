provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "db-demo-rg-test-sam"
  location = "Central US"

   tags = {
      environment="dev"
      CreatedBy="sampath"
      ModeOfDeployment="CICD"
  }
}


resource "azurerm_sql_server" "example" {
  name                         = "demo-sqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "admin"
  administrator_login_password = "admin@1234"
}

resource "azurerm_mssql_database" "test" {
  name           = "demo-db"
  server_id      = azurerm_sql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = false

  tags = {
      environment="dev"
      CreatedBy="sampath"
      ModeOfDeployment="CICD"
  }

}