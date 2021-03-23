terraform {
 backend "azurerm" {}
}
provider "azurerm" {
 # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
 //version         = "=2.18.0"
 subscription_id = "1d021829-09c2-47de-9160-f9597e6f66ad"
 features {}
 skip_provider_registration = "true"

}




resource "azurerm_app_service_plan" "my_service_plan" {
 name                = "myserviceplan2190"
 location            = "France central"
 resource_group_name = "griffin-resource-name"
 kind                = "Linux"
 reserved            = true

 sku {
   tier     = "PremiumV2"
   size     = "P2v2"
   capacity = "3"
 }
}
resource "azurerm_mysql_server" "main" {
  name                = "sqlserver2190"
  location            = "France central"
  resource_group_name = "griffin-resource-name"

  sku {
    name     = "B_Gen5_2"
    capacity = 2
    tier     = "Basic"
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "mysqladminun"
  administrator_login_password = "Puvi@130317"
  version                      = "5.7"
  ssl_enforcement              = "Disabled"
}

# This is the database that our application will use
resource "azurerm_mysql_database" "main" {
  name                = "hcldb21"
  resource_group_name = "griffin-resource-name"
  server_name         = azurerm_mysql_server.main.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# This rule is to enable the 'Allow access to Azure services' checkbox
resource "azurerm_mysql_firewall_rule" "main" {
  name                = "x1-mysql-firewall"
  resource_group_name = "griffin-resource-name"
  server_name         = azurerm_mysql_server.main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

locals {
 env_variables = {
   DOCKER_REGISTRY_SERVER_URL            = "https://arc01.azurecr.io"
   DOCKER_REGISTRY_SERVER_USERNAME       = "ACR021"
   DOCKER_REGISTRY_SERVER_PASSWORD       = "Puvi@130317"
   WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    

    # These are app specific environment variables
    SPRING_PROFILES_ACTIV     = "prod,swagger"
    SPRING_DATASOURCE_URL      = "jdbc:mysql://azurerm_mysql_server.main.fqdn:3306/azurerm_mysql_database.main.name?useUnicode=true&characterEncoding=utf8&useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC"
    SPRING_DATASOURCE_USERNAME = "azurerm_mysql_server.main.administrator_login@$azurerm_mysql_server.main.name"
    SPRING_DATASOURCE_PASSWOR = "var.my_sql_master_password"
  
 }
}


 


resource "azurerm_app_service" "my_app_service_container" {
 name                    = "myappservicecontainer2190"
 location                = "France central"
 resource_group_name     = "griffin-resource-name"
 app_service_plan_id     = azurerm_app_service_plan.my_service_plan.id
 https_only              = true
 client_affinity_enabled = true
 site_config {
   scm_type  = "VSTSRM"
   always_on = "true"

   linux_fx_version  = "DOCKER|arc01.azurecr.io/myapp:latest"#define the images to usecfor you application

   
 }
 app_settings = local.env_variables 
}


