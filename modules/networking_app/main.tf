#tagging strategy
locals {
  common_tags = {
    project = var.project_name
    Environment = var.env
    ManagedBy = "Terraform"
    Owner = "solomon-mwaniki"
  }
}

#resource group
resource "azurerm_resource_group" "main" {
  name = "rg-${var.project_name}-${var.env}"
  location = var.location
  tags = local.common_tags
  
}

# 3.networking
resource "azurerm_virtual_network" "vnet" {
  name = "vnet-${var.env}"
  address_space = [var.vnet_cidr]
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = local.common_tags
}
resource "azurerm_subnet" "subnet" {
  name = "snet-${var.env}"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [cidrsubnet(var.vnet_cidr, 2, 0)]
  
}

# 4. virtual machine infrastructure (NIC + VM)
resource "azurerm_network_interface" "nic" {
  name = "nic-${var.env}"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
  tags = local.common_tags
  
}

resource "azurerm_linux_virtual_machine" "vm" {
  name = "vm-${var.env}"
  resource_group_name = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
  size = var.vm_size
  admin_username = var.admin_user
  network_interface_ids = [ azurerm_network_interface.nic.id ]

disable_password_authentication = false
admin_password = "P@ssw0rd2026!"

os_disk {
  caching = "ReadWrite"
  storage_account_type = "Standard_LRS"
}

source_image_reference {
  publisher = "Canonical"
offer = "0001-com-ubuntu-server-jammy"
sku = "22_04-lts"
version = "latest"
}
tags = local.common_tags
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-${var.env}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}
