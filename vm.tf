
resource "azurerm_virtual_network" "as02-vnet" {
  name                = "vnet"
  location            = azurerm_resource_group.as02-atividade.location
  resource_group_name = azurerm_resource_group.as02-atividade.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_public_ip" "as02-ip" {
  name                = "publicip"
  resource_group_name = azurerm_resource_group.as02-atividade.name
  location            = azurerm_resource_group.as02-atividade.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "as02-ni" {
  name                = "nic"
  location            = azurerm_resource_group.as02-atividade.location
  resource_group_name = azurerm_resource_group.as02-atividade.name

  ip_configuration {
    name                          = "ipvm"
    subnet_id                     = azurerm_subnet.as02-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.as02-ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nicnsg" {
  network_interface_id      = azurerm_network_interface.as02-ni.id
  network_security_group_id = azurerm_network_security_group.as02-nsg.id
}

resource "azurerm_linux_virtual_machine" "as02-vm" {
  name                = "virtualmachine"
  resource_group_name = azurerm_resource_group.as02-atividade.name
  location            = azurerm_resource_group.as02-atividade.location
  size                = "Standard_DS1_v2"
  admin_username      = var.user-vm
  admin_password      = var.password-user-vm
  disable_password_authentication = false
  
  network_interface_ids = [
    azurerm_network_interface.as02-ni.id,
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

output "publicip" {
  value = azurerm_public_ip.as02-ip.ip_address
}