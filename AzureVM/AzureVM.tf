data "azurerm_resource_group" "rsg" {
  name = "sqlrsgp"
}

data "azurerm_virtual_network" "mainvnet" {
  name                = "mainvnet"
  resource_group_name = data.azurerm_resource_group.rsg.name
}

data "azurerm_subnet" "subnet1" {
  name                 = "subnet_1"
  resource_group_name  = data.azurerm_resource_group.rsg.name
  virtual_network_name = data.azurerm_virtual_network.mainvnet.name
}

resource "azurerm_public_ip" "publicip" {
  name                    = "public-ip"
  location                = data.azurerm_resource_group.rsg.location
  resource_group_name     = data.azurerm_resource_group.rsg.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
}


resource "azurerm_network_interface" "netinterface" {
  name                = "netinterface-nic"
  location            = data.azurerm_resource_group.rsg.location
  resource_group_name = data.azurerm_resource_group.rsg.name

  ip_configuration {
    name                          = "private-ip"
    subnet_id                     = data.azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    #private_ip_address_allocation = "Static"
    #private_ip_address            = "10.0.1.4"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_windows_virtual_machine" "Windowsvm" {
  name                          = "Win2019srv"
  resource_group_name           = data.azurerm_resource_group.rsg.name
  location                      = data.azurerm_resource_group.rsg.location
  size                          = "Standard_B1s"
  admin_username                = "winadmin"
  admin_password                = "Apple.121"
  network_interface_ids = [
    azurerm_network_interface.netinterface.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
