terraform {
  required_version = ">= 0.12.0"
}
provider "azurerm" {
features {}
}

module "resource_group" {
 source ="../modules/resourcegroup"
 resource_group_name = "${var.prefix}-${var.resource_group_name}"
 location = "${var.location}"
}

module "vnet" {
  source              = "../modules/vnet"
  resource_group_name = "${module.resource_group.resource_group_name}"
  location            = "${module.resource_group.location}"
  vnet_name           = "${var.prefix}-vnet"
  address_space       = "${var.address_space}"
}

module "application-subnets" {
  source              = "../modules/subnet"
  resource_group_name = "${module.resource_group.resource_group_name}"
  location            = "${module.resource_group.location}"
  vnet_name           = "${module.vnet.vnet_name}"
  subnet_names         ="${var.subnet_names}"
  subnet_address_prefixes = "${var.subnet_address_prefixes}"
}
