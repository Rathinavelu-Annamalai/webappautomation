 terraform {
  required_version = ">= 0.11" 
 backend "azurerm" {
  //storage_account_name = "__terraformstorageaccount__"
  //container_name       = "terraform"
  //  key                  = "terraform.tfstate"
	// access_key  ="__storagekey__"
  features{}
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