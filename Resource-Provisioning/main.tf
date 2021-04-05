provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  features {}
}

terraform {
  backend "azurerm" {
  }
}

/*resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.default_tags}"
} */

/*data "azurerm_resource_group" "rg" {
  name                = var.resource_group_name
  location            = var.location
} */

module "rg" {
source= "../modules/resourcegroup"
name=var.resource_group_name
location=var.location

}

module "application-vnet" {
  source              = "../modules/vnet"
  resource_group_name =  module.rg.name
  location            = module.rg.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  tags= {
   Environment = "dev"
   CreatedBy= "sampath"
   ModeOfDeployment = "cicd"
  }
}

module "subnets" {
source                    = "../modules/subnet"
//name                      = var.subnet_names[count.index]
name               = var.subnet_names
 // virtual_network_name      = module.application-vnet.virtual_network_name
 vnet_name      = module.application-vnet.vnet_name
resource_group_name       = data.azurerm_resource_group.rg.name
//address_prefix            = var.subnet_prefixes[count.index]
subnet_prefixes           = var.subnet_prefixes
// count              = length(var.subnet_names)
}



