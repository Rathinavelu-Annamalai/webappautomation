terraform{
    required_providers{
        azurerm={
            source = "hashicorp/azurerm"
            version=">=0.1"
        }

    }
}

provider "azurerm" { 
  features {}
}



#Create WebAp
module "webapp" {
  source    = "./modules/webapp"

  appsplanname    = "appserplanvhcl90"
appsname="appservhcl90"
  rgname    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}
