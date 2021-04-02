module "rg" {
 source= "./modules/resourcegroup"
 name=var.resource_group_name
 location=var.location

}

module "vnet" {
  source="./modules/vnet"
  name                = var.vnet_name
  address_space       = "10.0.0.0/16"
  location            = module.rg.location
  resource_group_name = module.rg.name
} 

module "snet" {
source= "./modules/subnet"
  virtual_network_name      = module.vnet.vnet_name
  resource_group_name       = module.rg.name
  address_prefix            = "10.0.1.0/24"
  //count                     = length(var.subnet_names)
}


 /*resource "azurerm_availability_set" "vm" {
  name                         = "${var.prefix}-avset"
  location                     = azurerm_resource_group.main.location
  resource_group_name          = azurerm_resource_group.main.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}*/


resource "azurerm_network_interface" "main" {
  //count=length(var.vm_count)
  name                = module.rg.name-vnet
  resource_group_name = module.rg.name
  location            = module.rg.location

  ip_configuration {
    name                          = internal
    subnet_id                     = module.subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
  
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = module.rg.name-vm
  resource_group_name             = module.rg.name
 // availability_set_id             = azurerm_availability_set.vm.id
  //zone= var.server_zones[count.index]
  location                        =module.rg.location
  size                            = "Standard_D2s_v3"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  //count=length(var.vm_count)
   network_interface_ids = [
  azurerm_network_interface.main.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}



