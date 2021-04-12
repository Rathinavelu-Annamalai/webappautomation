variable "resource_group_name" {
  description = ""
  default     = ""
}

variable "location" {
  description = ""
  default     = ""
}


variable "add_endpoint" {
  description = "should we be adding an endpint, leave this as is"
  default     = false
}


variable "address_space" {
  description = ""
  default     = ""
}

variable "subnet_names" {
  description = ""
  //type= list
  //default=[]
}

variable "subnet_address_prefixes" {
  description = ""
  //type= list
  //default= []
}


/*variable "application" {
  description = ""
  default     = ""
}

variable "environment" {
  description = ""
  default     = ""
}*/

variable "appserviceplan" {
description = ""
default     = ""
}

variable "appservicename" {
description = ""
 default     = ""
}

variable "appinsightname" {
description = ""
  default     = ""
}

variable "azuremonitorname" {
 description = ""
  default     = ""   
 }

variable "tags" {
type = map
default = {
  environment = "dev-demo"
  CreatedBy = "terraform"
  ModeOfDeployment = "Automation"
}
}