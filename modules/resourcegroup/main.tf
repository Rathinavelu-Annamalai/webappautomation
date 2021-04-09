/*provider "azurerm" {
  version = "=2.33.0"
  features {}
} */

resource "azurerm_resource_group" "rg"{
    name=var.resource_group_name
    location=var.location
    /*tags= {
      CreatedBy="sampath"
      Environment="dev"
      ModeOfDeployment="cicd"    
    }*/
    tags = var.tags
}