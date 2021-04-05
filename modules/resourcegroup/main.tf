terraform {
  required_version = ">= 0.12.0"
}
  provider "azurerm" {
  features {}
}


resource "resource_group_name" "rg"{
    name=var.resource_group_name
    location=var.location
    tags=var.tags
}