terraform {
	  required_version = ">= 0.11" 
	 backend "azurerm" {
	  storage_account_name = "__terraformstorageaccount__"
	    container_name       = "terraform"
	    key                  = "terraform.tfstate"
	access_key  ="__storagekey__"
	  features{}
	}
	}
	  provider "azurerm" {
	    version = "=2.0.0"
	features {}
	}
	resource "azurerm_resource_group" "dev" {
		name     = "__resourcegroup__"
	  //name     = "dev-rg-cu-plutus-webapp21"
	  location = "Central US"
	  tags = {
	   environment = "dev-demo"
	   createdby="terraform"
	  modeofdeployment= "auto"
	  }
	}
	
	resource "azurerm_virtual_network" "vnet" {
	  name ="__virtualnetwork__"
	  //name                = "dev-plutus-webapp-vn"
	  location            = azurerm_resource_group.dev.location
	  resource_group_name = azurerm_resource_group.dev.name
	  address_space       = var.vnet_address_prefix
	   tags = {
	   environment = "dev"
	   createdby="poorani"
	   modeofdeployment= "azurecicd"
	  }
	}
	
	resource "azurerm_subnet" "integrationsubnet" {
	  name="__subnetwork__"
	  //name                 = "devplutuswebappsn"
	  resource_group_name  = azurerm_resource_group.dev.name
	  virtual_network_name = azurerm_virtual_network.vnet.name
	  address_prefix     = var.subnet_address_prefix
	  delegation {
	    name = "delegation"
	    service_delegation {
	      name = "Microsoft.Web/serverFarms"
	    }
	  }
	 
	}
	
	resource "azurerm_network_security_group" "example" {
	  name="__nsg__"
	  //name                = "dev-plutus-webapp-nsg"
	  location            = azurerm_resource_group.dev.location
	  resource_group_name = azurerm_resource_group.dev.name
	
	  security_rule {
	    name                       = "nsgrule1"
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
	
	resource "azurerm_subnet_network_security_group_association" "example" {
	  subnet_id                 = azurerm_subnet.integrationsubnet.id
	  network_security_group_id = azurerm_network_security_group.example.id
	}
	
	resource "azurerm_app_service_plan" "dev" {
	  name                = "__appserviceplan__"
	  //location            = "Central US" 
	  location="${azurerm_resource_group.dev.location}"
	  //resource_group_name = "appdbwebtest"
	resource_group_name="${azurerm_resource_group.dev.name}"
	
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
	
	resource "azurerm_application_insights" "example" {
	  name                = "__appinsights__"
	  location            = azurerm_app_service_plan.dev.location
	  resource_group_name = azurerm_app_service_plan.dev.resource_group_name
	  application_type    = "web"
	tags = {
	    environment = "dev"
	    createdby="poorani"
	    modeofdeployment= "azurecicd"
	  }
	}
	
	resource "azurerm_app_service" "dev" {
	  name                = "__appservicename__"
	  location            = azurerm_app_service_plan.dev.location
	  resource_group_name =  azurerm_app_service_plan.dev.resource_group_name
	  app_service_plan_id = "${azurerm_app_service_plan.dev.id}"
	  depends_on = [azurerm_app_service_plan.dev , azurerm_monitor_autoscale_setting.asplan1]
	  app_settings = {
	    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.example.instrumentation_key}",
	    "WEBSITE_DNS_SERVER": "168.63.129.16",
	    "WEBSITE_VNET_ROUTE_ALL": "1",
		"APPINSIGHTS_PROFILERFEATURE_VERSION":"1.0.0",
"APPINSIGHTS_SNAPSHOTFEATURE_VERSION":"1.0.0",
"ApplicationInsightsAgent_EXTENSION_VERSION":"~2",
"DiagnosticServices_EXTENSION_VERSION":"~3",
"InstrumentationEngine_EXTENSION_VERSION":"disabled",
"SnapshotDebugger_EXTENSION_VERSION":"disabled",
"XDT_MicrosoftApplicationInsights_BaseExtensions":"disabled",
"XDT_MicrosoftApplicationInsights_Mode":"recommended"


	  }
	
	    tags = {
	    environment = "dev"
	    createdby="poorani"
	    modeofdeployment= "azurecicd"
	  }
	
	}
	resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
	  app_service_id  = azurerm_app_service.dev.id
	  subnet_id       = azurerm_subnet.integrationsubnet.id
	}
	
	
	
	resource "azurerm_monitor_autoscale_setting" "asplan1" {
	  name                ="__azuremonitor__"
	  resource_group_name = azurerm_app_service_plan.dev.resource_group_name
	  location            =  azurerm_app_service_plan.dev.location
	  target_resource_id  = azurerm_app_service_plan.dev.id
	
	  profile {
	    name = "default"
	
	    capacity {
	      default = 1
	      minimum = 1
	      maximum = 2
	    }
	
	    rule {
	      metric_trigger {
	        metric_name        = "CpuPercentage"
	        metric_resource_id = azurerm_app_service_plan.dev.id
	        time_grain         = "PT1M"
	        statistic          = "Average"
	        time_window        = "PT5M"
	        time_aggregation   = "Average"
	        operator           = "GreaterThan"
	        //threshold          = var.cpuUpperThreshold
	     threshold          = 80
	      }
	
	      scale_action {
	        direction = "Increase"
	        type      = "ChangeCount"
	        value     = "1"
	        cooldown  = "PT15M"
	      }
	    }
	
	    rule {
	      metric_trigger {
	        metric_name        = "CpuPercentage"
	        metric_resource_id = azurerm_app_service_plan.dev.id
	        time_grain         = "PT1M"
	        statistic          = "Average"
	        time_window        = "PT5M"
	        time_aggregation   = "Average"
	        operator           = "LessThan"
	        threshold          = 30
	      }
	
	      scale_action {
	        direction = "Decrease"
	        type      = "ChangeCount"
	        value     = "1"
	        cooldown  = "PT15M"
	      }
	    }
	  }
	
	  notification {
	    email {
	      send_to_subscription_administrator    = false
	      send_to_subscription_co_administrator = false
	      custom_emails                         = ["poorani.kamalakannan@allianzlife.com"]
	    }
	  }
	    depends_on = [azurerm_app_service_plan.dev]
	    tags = {
	    environment = "dev"
	    createdby="poorani"
	    modeofdeployment= "azurecicd"
	  }
	}
