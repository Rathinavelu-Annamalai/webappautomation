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

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
 // name="${var.nsg_names[count.index]}"
  //count=length(var.nsg_names)
  //location            = azurerm_resource_group.dev.location
  location            = "${var.location}"
  //resource_group_name = "${azurerm_resource_group.dev.name}""
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  security_rule = [
    {
    name                       = "allow https"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
   },
   {
    name                       = "allow http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
   }
]



  
  resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = "${module.application-subnets.subnet_id}"
  network_security_group_id = azurerm_network_security_group.example.id
}