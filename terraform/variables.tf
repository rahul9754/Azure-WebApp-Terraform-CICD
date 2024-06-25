variable "resource_group_name" {}

variable "location" {}

variable "vm_name" {}

variable "vm_size" {}

variable "admin_username" {}

variable "admin_password" {
    sensitive = true
}

variable "lb_name" {
}

variable "lb_pub_ip_name" {
  
}

variable "vnet_name" {
  
}

variable "subnet_name" {
  
}

variable "nsg_name" {
  
}

variable "lbFrontendPort" {
  
}

