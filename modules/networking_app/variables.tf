variable "project_name" {
  type = string
  description = "multiterraform"
  
}

variable "env" {
  type = string
  description = "dev"
  
}

variable "location" {
  type = string
  description = "southafricanorth"
  
}

variable "vnet_cidr" {
  type = string
  description = "The IP range for the virtual network"
  
}

variable "vm_size" {
  type = string
  
}

variable "admin_user" {
  type = string
  description = "azureuser"
  
}
