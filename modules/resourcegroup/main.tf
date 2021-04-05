provider "azurerm" {
  features {}
}
/*
data "azurerm_resource_group" "example" {
  name     = "appdbwebtest"
  location = "Central US"

 
}*/

resource "resource_group_name" "rg"{
    name=var.resource_group_name
    location=var.location
    tags=
    {
      CreatedBy="sampath"
      Environment="dev"
      ModeOfDeployment="cicd"
    
    }
}