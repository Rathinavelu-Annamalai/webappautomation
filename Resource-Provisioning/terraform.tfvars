//application = "myapp"
//environment = "env"
resource_group_name ="dev-rg-cu-plutus-webapp26"
location    = "Central US"


address_space            = "10.0.0.0/16"
//subnet_address_prefixes  = [ "10.0.1.0/24", "10.0.2.0/24"]
subnet_address_prefixes  = ["10.0.1.0/24"]
//subnet_names             = [ "subnet1", "subnet2"]
subnet_names             = ["subnet1"]
appserviceplan  = "dev-plutus-webapp21-asp"
appservicename  =  "plutusui-webapp21"
appinsightname  = "dev-plutus-webapp21-asp-ai"
azuremonitorname = "dev-plutus-webapp21-asp-autoscale"
