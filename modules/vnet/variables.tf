variable "resource_group_name" {
  description = "The name of the resource group we want to use"
  default     = ""
}

variable "location" {
  description = "The location/region where we are creating the resource"
  default     = ""
}

# Everything below is for the module

variable "vnet_name" {
  description = "Name of the vnet to create"
  default     = ""
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  default     = ""
}

variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default     = []
}