resource_group = {
  rg1 = {
    rg_name  = "mehar_rg"
    location = "east us"
  }

}

virtual_network = {
  vnet1 = {
    vnet_name     = "meharVnet"
    rg_name       = "mehar_rg"
    location      = "east us"
    address_space = ["10.0.0.0/16"]
  }

}

subnet = {
  subnet1 = {
    subnet_name      = "meharsubent1"
    vnet_name        = "meharVnet"
    rg_name          = "mehar_rg"
    location         = "east us"
    address_prefixes = ["10.0.0.0/24"]

  }

}

public_ip = {

  pip1 = {

    pip_name          = "mehapip1"
    rg_name           = "mehar_rg"
    location          = "east us"
    allocation_method = "Static"

  }

}



network_nic = {
  nic1 = {
    nic_name        = "meharnic1"
    location        = "east us"
    rg_name         = "mehar_rg"
    ip_config_name  = "internal"
    private_ip_meth = "Dynamic"
    subnet_name     = "meharsubent1"
    vnet_name       = "meharVnet"
  }

  nic2 = {
    nic_name        = "meharnic2"
    location        = "east us"
    rg_name         = "mehar_rg"
    ip_config_name  = "internal"
    private_ip_meth = "Dynamic"
    subnet_name     = "meharsubent2"
    vnet_name       = "meharVnet"
  }
}


virtual_machine = {

  vm1 = {

    vm_name        = "lbvm1"
    rg_name        = "mehar_rg"
    location       = "east us"
    vm_size        = "Standard_F2"
    admin_username = "Useradmin"
    admin_password = "Useradmin@1234"
    nic_name       = "meharnic1"

  }

  vm2 = {

    vm_name        = "lbvm2"
    rg_name        = "mehar_rg"
    location       = "east us"
    vm_size        = "Standard_F2"
    admin_username = "Useradmin"
    admin_password = "Useradmin@1234"
    nic_name       = "meharnic2"

  }
}

loadbalancer = {

  lb1 = {
    lb_name           = "TestLoadBalancer"
    location          = "east us"
    rg_name           = "mehar_rg"
    frontend_ip_name  = "frontendlbip"
    backend_pool_name = "BackEndAddressPool"
    lb_rule_name      = "newrule1"
    protocol          = "Tcp"
    frontend_port     = 80
    backend_port      = 80
    lb_prob_name      = "lbprob1"
    lb_prob_port      = 20
    pip_name          = "mehapip1"


  }
}

network_nsg = {

  nsg1 = {
    nsg_name                   = "securensg"
    location                   = "east us"
    rg_name                    = "mehar_rg"
    rule_name                  = "allow_http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range           = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

}