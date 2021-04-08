variable "resource_group_name" {
  description = "The name of the resource group we want to use"
  default     = ""
}

variable "location" {
  description = "The location/region where we are crrating the resource"
  default     = ""
}



# Everything below is for the module

variable "vnet_name" {
  description = "Name of the vnet to create the subnets in"
  default     = ""
}

variable "subnets" {
  //type        = list(string)
  description = "The address prefix to use for the subnet."
  default     = ""
}

variable "add_endpoint" {
  description = "should we be adding an endpint, leave this as is"
  default     = false
}