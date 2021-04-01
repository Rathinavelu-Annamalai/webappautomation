resource "azurerm_subnet" "subnet" {
  name                      = var.subnet_names[count.index]
  virtual_network_name      = var.virtual_network_name
  resource_group_name       = var.resource_group_name
  address_prefix            = var.subnet_prefixes[count.index]
  count                     = length(var.subnet_names)
}

/*resource "azurerm_subnet" "subnet-endpoint" {
  count                = "${var.add_endpoint == true ? length(var.subnets) : 0}"
  resource_group_name  = "${var.resource_group_name}"
  name                 = "${lookup(var.subnets[count.index], "name", "")}"
  virtual_network_name = "${var.vnet_name}"
  address_prefix       = "${lookup(var.subnets[count.index], "prefix", "")}"
  service_endpoints    = ["${lookup(var.subnets[count.index], "service_endpoint", "")}"]
} */
