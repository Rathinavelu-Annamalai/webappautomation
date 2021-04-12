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
      
     /* delegation {
      name = "delegation"
      service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }*/
      delegation {
	    name = "delegation"
	    service_delegation {
	      name = "Microsoft.Web/serverFarms"
	    }

  }
} 


resource "azurerm_network_security_group" "example" {
 name                = "dev-plutus-webapp-nsg"
 location            = "${var.location}"
 resource_group_name = "${var.resource_group_name}"

  security_rule {
    name                       = "allowhttps"
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
    name                       = "allowhttp"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
   }*/
   /*tags = {
   environment = "dev"
   createdby="sampath"
   modeofdeployment= "azurecicd"
  }*/
  tags = var.tags
}
  
 resource "azurerm_subnet_network_security_group_association" "example" {
  //subnet_id                 = "${azurerm_subnet.subnet.*.id}"
  //subnet_id = flatten(azurerm_subnet.subnet.id)[0]
  count=length(var.subnet_names)
  subnet_id= "${azurerm_subnet.subnet.0.id}"
  network_security_group_id = azurerm_network_security_group.example.id
} 