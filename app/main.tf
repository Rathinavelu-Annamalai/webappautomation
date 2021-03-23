terraform {
 backend "azurerm" {}
}
provider "azurerm" {
 # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
 //version         = "=2.18.0"
 //subscription_id = var.acr_subscription_id
 features {}
 skip_provider_registration = "true"

}




resource "azurerm_app_service_plan" "my_service_plan" {
 name                = "myserviceplan21"
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
  name                = "${var.prefix}-mysql-server"
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
  administrator_login_password = "${var.my_sql_master_password}"
  version                      = "5.7"
  ssl_enforcement              = "Disabled"
}

# This is the database that our application will use
resource "azurerm_mysql_database" "main" {
  name                = "${var.prefix}_mysql_db"
  resource_group_name = "${azurerm_resource_group.main.name}"
  server_name         = "${azurerm_mysql_server.main.name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# This rule is to enable the 'Allow access to Azure services' checkbox
resource "azurerm_mysql_firewall_rule" "main" {
  name                = "${var.prefix}-mysql-firewall"
  resource_group_name = "${azurerm_resource_group.main.name}"
  server_name         = "${azurerm_mysql_server.main.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

locals {
 env_variables = {
   DOCKER_REGISTRY_SERVER_URL            = "https://index.docker.io"
   //DOCKER_REGISTRY_SERVER_USERNAME       = "ACR021"
  // DOCKER_REGISTRY_SERVER_PASSWORD       = ""
 }
}


resource "azurerm_app_service" "my_app_service_container" {
 name                    = "myappservicecontainer21"
 location                = "France central"
 resource_group_name     = "griffin-resource-name"
 app_service_plan_id     = azurerm_app_service_plan.my_service_plan.id
 https_only              = true
 client_affinity_enabled = true
 site_config {
   scm_type  = "VSTSRM"
   always_on = "true"

   linux_fx_version  = "DOCKER|index.docker.io/nginx"#define the images to usecfor you application

   
 }
 app_settings = local.env_variables 
}


