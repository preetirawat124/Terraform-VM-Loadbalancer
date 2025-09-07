resource "azurerm_network_interface" "example" {
    for_each = var.network_nic
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = each.value.ip_config_name
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = each.value.private_ip_meth 
    
  }
}


data "azurerm_subnet" "subnet" {
    for_each = var.network_nic
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}





variable "network_nic" {

    type = map(any)
  
}