variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default="demo"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default="northeurope"
  
}

variable "resource_group_name" {
  description = "Default resource group name that the network will be created in."
  default     = "demo-rg"
}

variable "username" {
  description = "User Name"
  default="sampath"
  
}

variable "password" {
  description = "password"
  default="sampath@123"
  
}

/*variable "vm_count" {
default= ["1","2"]
}

variable "server_zones" {
default=["1","2"]
}*/
