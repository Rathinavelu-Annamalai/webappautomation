provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  features {}
}

terraform {
  backend "azurerm" {
  }
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.default_tags}"

}

module "application-vnet" {
  source              = "./modules/vnet"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location            = "${var.location}"
  tags                =  "${var.default_tags}"
  vnet_name           = "${var.vnet_name}"
  address_space       = "${var.address_space}"
}

module "subnets" {
source                    = "./modules/subnet"
name                      = var.subnet_names[count.index]
virtual_network_name      = var.vnet_name
resource_group_name       = "${azurerm_resource_group.resource_group.name}"
address_prefix            = var.subnet_prefixes[count.index]
count                     = length(var.subnet_names)
}



