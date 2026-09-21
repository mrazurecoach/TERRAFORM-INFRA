# Create a resource group

terraform {
  backend "azurerm" {
    resource_group_name  = "az-strg-backend-rgp"
    storage_account_name = "azstrgbackend"
    container_name       = "backendcontainer"
    key                  = "terraform.tfstate"
  }
}


resource "azurerm_resource_group" "trf-rgp" {
  name     = var.resourcegroupname
  location = var.location
  tags = {
    Environment = "Development"
    Project     = "Terraform"
    Owner       = "John Doe"
    department  = "IT"
  }
}

# Create a virtual network
  resource "azurerm_virtual_network" "trf-vnet" {
  resource_group_name = azurerm_resource_group.trf-rgp.name  
  name                = var.vnet
  location            = azurerm_resource_group.trf-rgp.location
  address_space       = ["10.20.0.0/16"]
}


resource "azurerm_subnet" "trf-subnet" {
  resource_group_name  = azurerm_resource_group.trf-rgp.name
  virtual_network_name = azurerm_virtual_network.trf-vnet.name
  name                 =  "web-subnet"
  address_prefixes     = ["10.1.0.0/24"]
}