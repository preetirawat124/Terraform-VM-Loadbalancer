module "resource_group" {
  source         = "../Child_Module/azurerm_resource_group"
  resource_group = var.resource_group

}
module "virtual_network" {
  source          = "../Child_Module/azurerm_virtual_network"
  virtual_network = var.virtual_network
  depends_on      = [module.resource_group]
}

module "subnet" {
  source     = "../Child_Module/azurerm_subnet"
  subnet     = var.subnet
  depends_on = [module.virtual_network]
}

module "public_Ip" {
  source     = "../Child_Module/azurerm_public_ip"
  public_ip  = var.public_ip
  depends_on = [module.resource_group]
}

module "network_interface" {
  source      = "../Child_Module/azurerm_NetworkInterface"
  network_nic = var.network_nic
  depends_on  = [module.subnet]

}

module "virtual_machines" {
  source          = "../Child_Module/azurem_virtual_machines"
  virtual_machine = var.virtual_machine
  depends_on      = [module.network_interface]

}

module "load_balancer" {
  source       = "../Child_Module/azurerm_load_balancer"
  loadbalancer = var.loadbalancer
  network_nic  = var.network_nic
  depends_on   = [module.public_Ip, module.network_interface, module.virtual_machines]

}

module "network_security_group" {
  source      = "../Child_Module/azurerm_Network_Security_Group"
  network_nsg = var.network_nsg
  network_nic = var.network_nic
  depends_on  = [module.network_interface]

}

