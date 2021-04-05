 terraform {
  required_version = ">= 0.11" 
 backend "azurerm" {
  
	}
	}
  provider "azurerm" {
    version = "=2.0.0"
features {}
}

resource "resource_group_name" "rg"{
    name=var.resource_group_name
    location=var.location
    tags=var.tags
}