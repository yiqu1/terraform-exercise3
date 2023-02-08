terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.42.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
}

resource "azurerm_resource_group" "rg1" {
  name     = "resoucegroup-rg1"
  location = "East Us"
}

resource "azurerm_storage_account" "first" {
  name                     = "storageaccountfirst"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    "name" = "first-sa"
  }
}

resource "azurerm_storage_account" "second" {
  name                     = "storageaccountsecond"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  depends_on = [
    azurerm_storage_account.first
  ]
  tags = {
    "name" = "second-sa"
  }
}
