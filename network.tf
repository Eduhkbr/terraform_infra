
resource "azurerm_subnet" "as02-subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.as02-atividade.name
  virtual_network_name = azurerm_virtual_network.as02-vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_network_security_group" "as02-nsg" {
  name                = "nsg"
  location            = azurerm_resource_group.as02-atividade.location
  resource_group_name = azurerm_resource_group.as02-atividade.name

  security_rule {
    name                       = "ssh"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "db"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
