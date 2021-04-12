variable "appserviceplan" {

}

variable "appservicename" {

}

variable "appinsightname" {

}

variable "azuremonitorname" {
    
}

variable "location" {}
variable "resource_group_name" {}
variable "tags" {
type = map
default = {
  environment = "dev-demo"
  CreatedBy = "terraform"
  ModeOfDeployment = "Automation"
}
}
