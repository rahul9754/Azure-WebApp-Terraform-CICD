resource "azurerm_network_interface" "nic" {
    name = "${var.vm_name}-nic"
    location = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
      name = "internal"
      subnet_id = var.subnet_id
      private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface_security_group_association" "nsg-association" {
    network_interface_id = azurerm_network_interface.nic.id
    network_security_group_id = var.nsg_id
}

locals {
  custom_data = <<CUSTOM_DATA
#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
CUSTOM_DATA
}

resource "azurerm_linux_virtual_machine" "vm" {
    name = var.vm_name
    resource_group_name = var.resource_group_name
    location = var.location
    size = var.vm_size
    admin_username = var.admin_username
    admin_password = var.admin_password
    custom_data = base64encode(local.custom_data)
    disable_password_authentication = false
    network_interface_ids = [ azurerm_network_interface.nic.id ]

    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }


    source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

}

