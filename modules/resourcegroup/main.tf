 terraform {
  required_version = ">=0.11" 
 backend "azurerm" {
  
	}
	}
  provider "azurerm" {
    version = ">=0.11"
features {}
}

resource "resource_group_name" "rg"{
    name=var.resource_group_name
    location=var.location
    tags=var.tags
}