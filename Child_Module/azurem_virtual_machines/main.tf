resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.virtual_machine
    name                = each.value.vm_name
    resource_group_name = each.value.rg_name
    location            = each.value.location
    size                = each.value.vm_size
    admin_username      = each.value.admin_username
    admin_password      = each.value.admin_password
    
    disable_password_authentication = false    
    
    network_interface_ids = [
       data.azurerm_network_interface.nic[each.key].id
    ]
    
 
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    
    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
    

}


data "azurerm_network_interface" "nic" {
    for_each = var.virtual_machine
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}


variable "virtual_machine" {

    type = map(any)
  
}