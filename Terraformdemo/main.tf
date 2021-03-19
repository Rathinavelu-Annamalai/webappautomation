
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
version = ">=1.0"
features{}
  
}
#Create WebAp
module "webapp" {
  source    = "./modules/webapp"

  appsplanname    = "appserplanvhcl90"
appsname="appservhcl90"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}
