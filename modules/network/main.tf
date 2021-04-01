
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.location
  address_space       = var.virtual_network_address_space
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                      = var.subnet_names[count.index]
  virtual_network_name      = var.virtual_network_name
  resource_group_name       = var.resource_group_name
  address_prefix            = var.subnet_prefixes[count.index]
  count                     = length(var.subnet_names)
}
