resource "azurerm_subnet" "subnet" {
  //name                      = var.subnet_names[count.index]
  name                      = var.subnet_names
  virtual_network_name                = var.vnet_name
  resource_group_name       = var.resource_group_name
  //address_prefix            = var.subnet_prefixes[count.index]
  address_prefix            = var.subnet_prefix
  //count              = length(var.subnet_names)
}

/*resource "azurerm_subnet" "subnet-endpoint" {
  count                = "${var.add_endpoint == true ? length(var.subnets) : 0}"
  resource_group_name  = "${var.resource_group_name}"
  name                 = "${lookup(var.subnets[count.index], "name", "")}"
  virtual_network_name = "${var.vnet_name}"
  address_prefix       = "${lookup(var.subnets[count.index], "prefix", "")}"
  service_endpoints    = ["${lookup(var.subnets[count.index], "service_endpoint", "")}"]
} */
