terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.109.0"
    }
  }

  backend "azurerm" {
        resource_group_name   = "myResourceGroup"
        storage_account_name  = "mystorageaccount"
        container_name        = "tfstate"
        key                   = "terraform.tfstate"
  }

}

provider "azurerm" {
    features {
      
    }
}

module "network" {
  source = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name
  nsg_name            = var.nsg_name
  
}

module "virtual-machine" {
  source = "./modules/virtual-machine"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  subnet_id           = module.network.subnet_id 
  nsg_id = module.network.nsg_id
  
  
}

module "lb" {
  source = "./modules/load-balancer"
  resource_group_name = var.resource_group_name
  location            = var.location
  lb_name             = var.lb_name
  lb_pub_ip_name      = var.lb_pub_ip_name
  nic_id              = module.virtual-machine.nic_id
  lbFrontendPort    = var.lbFrontendPort
  depends_on = [ module.network, module.virtual-machine ]
  

}


