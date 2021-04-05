terraform {
required_providers {
azurerm = {
source  = "hashicorp/azurerm"
version = "~> 2.43.0"
}
}
}
   


resource "resource_group_name" "rg"{
    name=var.resource_group_name
    location=var.location
    tags=var.tags
}