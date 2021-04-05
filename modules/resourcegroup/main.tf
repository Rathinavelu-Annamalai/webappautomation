provider "azurerm" {
  version = "=2.33.0"
  features {}
}
/*
data "azurerm_resource_group" "example" {
  name     = "appdbwebtest"
  location = "Central US"

 
}*/

resource "azurerm_resource_group" "rg"{
    name=var.resource_group_name
    location=var.location
    tags= {

      CreatedBy="sampath"
      Environment="dev"
      ModeOfDeployment="cicd"
    
    }
}