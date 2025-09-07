resource "azurerm_lb" "testlb" {
for_each = var.loadbalancer
  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name =     each.value.rg_name

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_name
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
  }
}
resource "azurerm_lb_backend_address_pool" "backend_pool" {
    for_each = var.loadbalancer
  loadbalancer_id = azurerm_lb.testlb[each.key].id
  name            = each.value.backend_pool_name
}
resource "azurerm_lb_rule" "lbrule" {
    for_each = var.loadbalancer
  loadbalancer_id                = azurerm_lb.testlb[each.key].id
  name                           = each.value.lb_rule_name
  protocol                       =  each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   =  each.value.backend_port
  frontend_ip_configuration_name =  each.value.frontend_ip_name
}
resource "azurerm_lb_probe" "lb_prob" {
    for_each = var.loadbalancer
  loadbalancer_id = azurerm_lb.testlb[each.key].id
  name            = each.value.lb_prob_name
  port            = each.value.lb_prob_port
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_nic_assocation" {
  for_each = var.network_nic
  network_interface_id    = data.azurerm_network_interface.nic[each.key].id
  ip_configuration_name   = "testconfiguration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool["lb1"].id
}



data "azurerm_public_ip" "pip" {
    for_each = var.loadbalancer
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
  
}

data "azurerm_network_interface" "nic" {
    for_each = var.network_nic
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}


variable "loadbalancer" {
    type = map(any)
  
}

variable "network_nic" {

    type = map(any)
  
}


