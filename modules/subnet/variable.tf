variable "resource_group_name" {
  description = "The name of the resource group we want to use"
  default     = ""
}

variable "location" {
  description = "The location/region where we are crrating the resource"
  default     = ""
}

variable "tags" {
  description = "The tags to associate the resource we are creating"
  //type        = "map"
  default     = ""
}

# Everything below is for the module

variable "vnet_name" {
  description = "Name of the vnet to create the subnets in"
  default     = "my-demo-vnet"
}

variable "subnet_names" {
  type        = list(string)
  description = "The address prefix to use for the subnet."
  default     = ["subnet1", "subnet2", "subnet3"]

}

variable "subnet_prefixes" {
  type        = list(string)
  description = "The address prefix to use for the subnet."
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "add_endpoint" {
  description = "should we be adding an endpint, leave this as is"
  default     = false
}
