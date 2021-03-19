
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.

features{}
  
}
#Create WebAp
module "webapp" {
  source    = "./modules/webapp"

  appsplanname    = "appserplanvhcl90"
appsname="appservhcl90"
  rgname    = azurerm_app_service_plan.example.name
  location  = azurerm_app_service_plan.example.location
}
