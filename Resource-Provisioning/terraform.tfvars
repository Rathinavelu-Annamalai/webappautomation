//application = "myapp"
//environment = "env"
resource_group_name ="dev-rg-cu-plutus-webapp2527"
location    = "Central US"


address_space            = "10.0.0.0/16"
//subnet_address_prefixes  = [ "10.0.1.0/24", "10.0.2.0/24"]
subnet_address_prefixes  = ["10.0.1.0/24"]
//subnet_names             = [ "subnet1", "subnet2"]
subnet_names             = ["subnet1"]
appserviceplan  = "dev-plutus-webapp2527-asp"
appservicename  =  "plutusui-webapp2527"
appinsightname  = "dev-plutus-webapp2527-asp-ai"
azuremonitorname = "dev-plutus-webapp2527-asp-autoscale"
