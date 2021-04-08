variable "appsplanname"{
    type=string
    description= "Name of the app service plan"
}
variable "appsname"{
    type=string
    description= "Name of the app service"
}
variable "resource_group_name" {
  description = "The name of the resource group we want to use"
  default     = ""
}

variable "location" {
  description = "The location/region where we are creating the resource"
  default     = ""
}