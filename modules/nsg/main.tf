resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  //location            = azurerm_resource_group.dev.location
  location            = "${var.location}"
  //resource_group_name = "${azurerm_resource_group.dev.name}""
  resource_group_name = "${var.resource_group_name}"

  security_rule {
    name                       = "allow https"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
   tags = {
   environment = "dev"
   createdby="poorani"
   modeofdeployment= "azurecicd"
  }
}


