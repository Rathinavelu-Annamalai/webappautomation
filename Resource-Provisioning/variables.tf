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

variable "subnet" {
  description = ""
  type= "list"
  default     = []
}

variable "application" {
  description = ""
  default     = ""
}

variable "environment" {
  description = ""
  default     = ""
}