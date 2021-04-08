output "subnet_name" {
  description = "The ids of subnets created inside the new vNet"
  value       = "${azurerm_subnet.subnet.id}"
}

output "vnet_subnet_names" {
  description = "The ids of subnets created inside the new vNet"
//  value       = "${flatten(concat(azurerm_subnet.subnet.*.name, azurerm_subnet.subnet-endpoint.*.name))}"
  value       = "${azurerm_subnet.subnet.name}"
}