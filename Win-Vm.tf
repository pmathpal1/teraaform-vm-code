data "azurerm_resource_group" "rg" {
  name     = var.rg_name
}

data "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}
resource "azurerm_network_interface" "vm-nic" {
  name                = "${var.prefix}-nic-name"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "${var.prefix}-vm_name"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = var.adminusername
  admin_password      = var.adminpassword
  network_interface_ids = [
    azurerm_network_interface.vm-nic.id,
  ]

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.source_image_reference[0].publisher
    offer     = var.source_image_reference[0].offer
    sku       = var.source_image_reference[0].sku
    version   = var.source_image_reference[0].version
  }
}