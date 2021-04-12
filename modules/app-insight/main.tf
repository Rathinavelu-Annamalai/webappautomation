resource "azurerm_application_insights" "example" {
	  //name                = "__appinsights__"
      name= "${var.appinsightname}"
	  location            =  "${var.location}"
	  resource_group_name="${var.resource_group_name}"
	  application_type    = "web"
	/* tags = {
	    environment = "dev"
	    createdby="sampath"
	    modeofdeployment= "azurecicd"
	  } */
	   tags = var.tags
	} 