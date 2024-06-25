
resource "azurerm_public_ip" "lbpubip" {
    name = var.lb_pub_ip_name
    location = var.location
    resource_group_name = var.resource_group_name
    allocation_method = "Static"
 
}


resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  frontend_ip_configuration {
    name = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lbpubip.id
  }

}

resource "azurerm_lb_backend_address_pool" "backendpool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "name" {
  network_interface_id = var.nic_id
  ip_configuration_name = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool.id
}

resource "azurerm_lb_probe" "hcprobe" {
  loadbalancer_id = azurerm_lb.lb.id
  name = "http-running-probe"
  port = 80
}

resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id = azurerm_lb.lb.id
  name = "LBRule"
  protocol = "Tcp"
  frontend_port = var.lbFrontendPort
  backend_port = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  # backend_address_pool_ids = var.bkPoolId
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.backendpool.id ]
  probe_id = azurerm_lb_probe.hcprobe.id
}
