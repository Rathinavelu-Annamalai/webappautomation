variable "appsplanname"{ 
    type = string
    description = "Name of the app service plan name"
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "location" {
    type = string
    description = "Azure location of storage account environment"
    default = "westus2"
}

variable "appsname"{
    type = string
    description = "Name of the app service plan name"
}

