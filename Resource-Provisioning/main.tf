terraform {
  required_version = ">= 0.12.0"
}
provider "azurerm" {
features {}
}


resource "azurerm_resource_group" "resource_group" {
  //name     = "${var.application}-${var.environment}"
  name="${var.resource_group_name}"
  location = "${var.location}"
  tags= {
      CreatedBy="sampath"
      Environment="dev"
      ModeOfDeployment="cicd"    
    }
}

module "application-vnet" {
  source              = "../modules/vnet"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location            = "${var.location}"
  vnet_name           = "${azurerm_resource_group.resource_group.name}-vnet"
  address_space       = "${var.address_space}"
}

module "application-subnets" {
  source              = "../modules/subnet"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location            = "${var.location}"
  vnet_name           = "${module.application-vnet.vnet_name}"
  subnet_names         ="${var.subnet_names}"
  subnet_address_prefixes = "${var.subnet_address_prefixes}"
}

module "webapp" {
 source = "../modules/webapp"



}

  resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
	  //app_service_id  = azurerm_app_service.dev.id
	  //subnet_id       = azurerm_subnet.integrationsubnet.id
    app_service_id = module.webapp.appservice_id
    subnet_id = module.application-subnets.subnet_id
	}

