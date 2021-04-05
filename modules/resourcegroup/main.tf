provider "azurerm" {
  features {}
}
/*
data "azurerm_resource_group" "example" {
  name     = "appdbwebtest"
  location = "Central US"

 
}*/

resource "azurerm_resource_group" "rg"{
    name=var.azurerm_resource_group
    location=var.location
    tags= {

      CreatedBy="sampath"
      Environment="dev"
      ModeOfDeployment="cicd"
    
    }
}