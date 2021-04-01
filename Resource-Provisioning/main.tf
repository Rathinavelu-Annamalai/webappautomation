provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.

  features {}
}
terraform {
  backend "azurerm" {
  }
}



module "network" {
source = "../modules/network"
//name              = var.virtual_network_name
location            = var.location
address_space       = var.virtual_network_address_space
resource_group_name = var.resource_group_name
//name                      = var.subnet_names[count.index]
virtual_network_name      = var.virtual_network_name
resource_group_name       = var.resource_group_name
address_prefix            = var.subnet_prefixes[count.index]
//count                     = length(var.subnet_names)

}