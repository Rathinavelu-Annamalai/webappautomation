resource "azurerm_subnet" "subnet" {
  count                = "${var.add_endpoint != true ? length(var.subnets) : 0}"
  resource_group_name  = "${var.resource_group_name}"
  name                 = "${lookup(var.subnets[count.index], "name", "")}"
  virtual_network_name = "${var.vnet_name}"
  address_prefixes       = "${lookup(var.subnets[count.index], "prefix", "")}"
}

/*resource "azurerm_subnet" "subnet-endpoint" {
  count                = "${var.add_endpoint == true ? length(var.subnets) : 0}"
  resource_group_name  = "${var.resource_group_name}"
  name                 = "${lookup(var.subnets[count.index], "name", "")}"
  virtual_network_name = "${var.vnet_name}"
  address_prefix       = "${lookup(var.subnets[count.index], "prefix", "")}"
  service_endpoints    = ["${lookup(var.subnets[count.index], "service_endpoint", "")}"]
}*/

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  /*security_rule = 
  {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
   {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }*/
   tags = {
   environment = "dev"
   createdby="poorani"
   modeofdeployment= "azurecicd"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.example.id
}