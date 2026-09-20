# Create a resource group
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