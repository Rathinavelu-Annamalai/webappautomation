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
 name                = "my_service_plan"
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

resource "azurerm_app_service" "my_app_service_container" {
 name                    = "my_app_service_container"
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

locals {
 env_variables = {
   DOCKER_REGISTRY_SERVER_URL            = "https://index.docker.io"
   //DOCKER_REGISTRY_SERVER_USERNAME       = "ACR021"
  // DOCKER_REGISTRY_SERVER_PASSWORD       = ""
 }
}


 app_settings = local.env_variables 
}


