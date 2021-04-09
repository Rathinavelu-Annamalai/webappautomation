/*resource "azurerm_subnet" "subnet" {
  count                = "${var.add_endpoint != true ? length(var.subnets) : 0}"
  resource_group_name  = "${var.resource_group_name}"
  name                 = "${lookup(var.subnets[count.index], "name", "")}"
  virtual_network_name = "${var.vnet_name}"
  address_prefix       = "${lookup(var.subnets[count.index], "prefix", "")}"
} */

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnet_names)
  resource_group_name  = "${var.resource_group_name}"
  name                 = "${var.subnet_names[count.index]}"
  virtual_network_name = "${var.vnet_name}"
  address_prefixes     = [var.subnet_address_prefixes[count.index]]
} 


resource "azurerm_network_security_group" "example" {
 name                = "example-nsg"
 location            = "${var.location}"
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
   /*{
    name                       = "allow http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
   }*/
   tags = {
   environment = "dev"
   createdby="sampath"
   modeofdeployment= "azurecicd"
  }
}
  
 resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = "${azurerm_subnet.subnet.*.id}"
  network_security_group_id = azurerm_network_security_group.example.id
} 