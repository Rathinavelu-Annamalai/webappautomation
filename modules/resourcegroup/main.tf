provider "azurerm" {
  features {}
}
/*
data "azurerm_resource_group" "example" {
  name     = "appdbwebtest"
  location = "Central US"

 
}*/

resource "azurerm_resource_group" "rg"{
    name="mytestrg"
    location="Central US"
    tags= {

      CreatedBy="sampath"
      Environment="dev"
      ModeOfDeployment="cicd"
    
    }
}