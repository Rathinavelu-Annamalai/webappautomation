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
  type= list
}

variable "subnet_address_prefixes" {
  description = ""
  type= list
}

/*variable "application" {
  description = ""
  default     = ""
}

variable "environment" {
  description = ""
  default     = ""
}*/