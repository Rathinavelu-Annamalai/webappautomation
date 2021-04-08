terraform {
  backend "azurerm" {
  storage_account_name = "__terraformstorageaccount__"
	    container_name       = "terraform"
	    key                  = "terraform.tfstate"
	access_key  ="__storagekey__"  	  

  }
}