resource "azurerm_network_security_group" "nsg" {
  for_each = var.network_nsg

  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
}

resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = var.network_nsg

  name                        = each.value.rule_name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = each.value.rg_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}

resource "azurerm_network_interface_security_group_association" "nic_assoc" {
  for_each = var.network_nic

  network_interface_id      = data.azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg["nsg1"].id
}

variable "network_nsg" {
  
}

data "azurerm_network_interface" "nic" {
    for_each = var.network_nic
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}

variable "network_nic" {

    type = map(any)
  
}