# Configure backend for storing state blobp
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-cognata"
    storage_account_name = "cognata"
    container_name       = "cognata"
    key                  = "cognata.terraform.tfstate"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.45.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = var.default_tags
}

resource "azurerm_container_registry" "acr" {
  name                = "acr${var.project_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = var.default_tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.location
  size                            = "Standard_B2s"
  disable_password_authentication = false
  admin_username                  = var.project_name
  admin_password                  = "Goodsecr3t!"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  tags = var.default_tags
}

resource "azurerm_virtual_machine_extension" "custom-script" {
  name                         = "custom-script"
  virtual_machine_id           = azurerm_linux_virtual_machine.vm.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  settings = jsonencode({
    "fileUris" = ["https://github.com/jkercov/CognataTest.git/config-install.sh"],
    "commandToExecute" = "sh config-install.sh"
  })
}


