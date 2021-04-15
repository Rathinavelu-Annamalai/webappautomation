variable "prefix" {
 description = ""
 default     = ""   
}

variable "resource_group_name" {
  description = ""
  default     = ""
}

variable "location" {
  description = ""
  default     = ""
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


variable "tags" {
type = map
default = {
  environment = "dev-demo"
  CreatedBy = "terraform"
  ModeOfDeployment = "Automation"
}
}