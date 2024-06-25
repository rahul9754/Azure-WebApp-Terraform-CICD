# public IP of LB

output "lbpubip" {
  value = azurerm_public_ip.lbpubip.ip_address
}
