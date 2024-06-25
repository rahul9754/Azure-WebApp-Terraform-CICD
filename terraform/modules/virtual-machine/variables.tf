variable "resource_group_name" {}

variable "location" {}

variable "vm_name" {}

variable "vm_size" {}

variable "admin_username" {}

variable "admin_password" {
    sensitive = true
}

variable "subnet_id" {
  
}

variable "nsg_id" {
  
}