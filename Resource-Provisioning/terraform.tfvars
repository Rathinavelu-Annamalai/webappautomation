//application = "myapp"
//environment = "env"
resource_group_name ="myresourcegroupdemo"
location    = "Central US"


address_space            = "10.0.0.0/16"
subnet_address_prefixes  = [ "10.0.1.0/24", "10.0.2.0/24"]
subnet_names             = [ "subnet1", "subnet2"]
appserviceplan  = "myappserviceplandemo"
appservicename  =  "plutusui-webapp21"
appinsightname  = "myappinsightnamedemo"
azuremonitorname = "myazuremonitordemo"
