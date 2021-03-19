variable "saname"{ 
    type = string
    description = "Name of the storage account"
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
