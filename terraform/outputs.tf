output "nic_id" {
  value = module.virtual-machine.nic_id
}

output "subnet_id" {
  value = module.network.subnet_id
  
}

output "nsg_id" {
  value = module.network.nsg_id   
}

output "lb_pub_ip" {
  value = module.lb.lbpubip
  
}