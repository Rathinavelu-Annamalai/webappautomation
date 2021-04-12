resource "azurerm_app_service_plan" "dev" {
	  //name                = "__appserviceplan__"
      name                 = "${var.appserviceplan}"
	  location            =  "${var.location}"
	  resource_group_name="${var.resource_group_name}"
	
	  sku {
	    tier = "Premiumv2"
	    size = "P1v2"
	  }
	   /* tags = {
	    environment = "dev"
	    createdby="sampath"
	    modeofdeployment= "azurecicd"
	  } */
	  tags = var.tags
	
	}
	
	/* resource "azurerm_application_insights" "example" {
	  //name                = "__appinsights__"
      name= "${var.appinsightname}"
	  location            =  "${var.location}"
	  resource_group_name="${var.resource_group_name}"
	  application_type    = "web"
	 tags = {
	    environment = "dev"
	    createdby="sampath"
	    modeofdeployment= "azurecicd"
	  }
	   tags = var.tags
	}  */
	
	/* module "app-insight"  {
		source = "./modules/app-insight"
	} */


	resource "azurerm_app_service" "dev" {
	  //name                = "__appservicename__"
	  name                 = "${var.appservicename}"
	  location            =  "${var.location}"
	  resource_group_name="${var.resource_group_name}"
	  app_service_plan_id = "${azurerm_app_service_plan.dev.id}"
	  depends_on = [azurerm_app_service_plan.dev , azurerm_monitor_autoscale_setting.asplan1]
	  app_settings = {      
        //"APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.example.instrumentation_key}",
		 "APPINSIGHTS_INSTRUMENTATIONKEY" = module.app-insight.instrumentation_key,
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
	
	    /* tags = {
	    environment = "dev"
	    createdby="sampath"
	    modeofdeployment= "azurecicd"
	  } */
	   tags = var.tags
	}
	
	
	resource "azurerm_monitor_autoscale_setting" "asplan1" {
	  //name                ="__azuremonitor__"
      name= "${var.azuremonitorname}"
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
	      custom_emails                         = ["sampath.palanisamy@allianzlife.com"]
	    }
	  }
	    depends_on = [azurerm_app_service_plan.dev]
	     /* tags = {
	    environment = "dev"
	    createdby="sampath"
	    modeofdeployment= "azurecicd"
	  } */

	  tags = var.tags
	}
