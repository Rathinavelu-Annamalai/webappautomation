
variable "vnet_name" {
  description = "Name of the vnet to create"
  default     = "my-demo-vnet"
} 

variable "resource_group_name" {
  description = "Default resource group name that the network will be created in."
  default     = "my-demo-rg"
}

variable "location" {
  description = "The location/region where the core network will be created."
  default     = "central us"
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type = string
   default     = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type = list(string)
   default     = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
     
}

variable "subnet_namees" {
  description = "A list of public subnets inside the vNet."
  type = list(string)
  default     = ["subnet1", "subnet2", "subnet3"]
    
}

variable "tags" {
 default=""
}
  
