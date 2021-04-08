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

variable "subnet_name" {
  description = ""
  //type= list(string)
  default     = ""
}

variable "subnet_prefix" {
  description = ""
  //type= list(string)
  default     = ""
}

variable "application" {
  description = ""
  default     = ""
}

variable "environment" {
  description = ""
  default     = ""
}