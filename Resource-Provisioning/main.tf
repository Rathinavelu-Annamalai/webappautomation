terraform {
  required_version = ">= 0.12.0"
}
provider "azurerm" {
features {}
}


resource "azurerm_resource_group" "resource_group" {
  name     = "${var.application}-${var.environment}"
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

module "application-webapp" {
  source              = "../modules/webapp"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location            = "${var.location}"
  appsname                = "__appservicename__"
  appsplanname ="__appserviceplan__"
  
}
resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
	  app_service_id  = "${module.application-webapp.appservice_id.id}"
        subnet_id="${module.application-subnets.vnet_subnets.id}"
      
	}
	
module "application-subnets" {
  source              = "../modules/subnet"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location            = "${var.location}"
    vnet_name           = "${module.application-vnet.vnet_name}"

  subnets = [
    {
      name   = "${azurerm_resource_group.resource_group.name}-subnet"
      prefix = "${var.subnet}"
    }
  ]
}

  
 