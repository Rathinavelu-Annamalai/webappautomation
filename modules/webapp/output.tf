output "asp_name" {
  value = azurerm_app_service_plan.dev.name
}
output "asp_id" { 
  value = azurerm_app_service_plan.dev.id
}
output "asp_rg" {
    value = azurerm_app_service_plan.dev.resource_group_name
}
output "asp_location" {
    value = azurerm_app_service_plan.dev.location
}
output "appservice_id" {
    value = azurerm_app_service.dev.id
}