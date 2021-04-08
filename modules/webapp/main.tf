resource "azurerm_app_service_plan" "dev" {
	  name                = var.appsplanname
	  //location            = "Central US" 
      location            = "${var.location}"
      resource_group_name = "${var.resource_group_name}"
	  //location="${azurerm_resource_group.dev.location}"
	  //resource_group_name = "appdbwebtest"
	//resource_group_name="${azurerm_resource_group.dev.name}"
    
	
	  sku {
	    tier = "Premiumv2"
	    size = "P1v2"
	  }
	    tags = {
	    environment = "dev"
	    createdby="poorani"
	    modeofdeployment= "azurecicd"
	  }
	
	}
	resource "azurerm_app_service" "dev" {
	  name                = var.appsname
      location            = "${var.location}"
      resource_group_name = "${var.resource_group_name}"
	  //location            = azurerm_app_service_plan.dev.location
	  //resource_group_name =  azurerm_app_service_plan.dev.resource_group_name
	  app_service_plan_id = "${azurerm_app_service_plan.dev.id}"
	  depends_on = [azurerm_app_service_plan.dev]
      //, azurerm_monitor_autoscale_setting.asplan1]
	  /*app_settings = {
	    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.example.instrumentation_key}",
	    "WEBSITE_DNS_SERVER": "168.63.129.16",
	    "WEBSITE_VNET_ROUTE_ALL": "1"
	  }*/
	
	    tags = {
	    environment = "dev"
	    createdby="poorani"
	    modeofdeployment= "azurecicd"
	  }
	
	}
	resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
	  app_service_id  = azurerm_app_service.dev.id
        subnet_id="${module.azurerm_subnet.subnet.id"
      //subnet_id       = azurerm_subnet.integrationsubnet.id
	}
	