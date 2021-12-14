variable "rg_name" {
  type = string
}

variable "vnet" {
  type = string
}
variable "subnet" {
  type = string
}
variable "prefix" {
  description = "Company Standard"
  type = string
  default ="HEI-GIS-INFRAINT-A-AZWE-"
  
}


variable "nic-name"{
  type = string
}
variable source_image_reference {
    type = list(object(
        {
         publisher = string
         offer = string
         sku = string
         version = string
        }
    ))
}


variable "vm_name" {
  type = string
  
}

variable "adminusername" {
  type = string
}

variable "adminpassword" {
  type = string
}
