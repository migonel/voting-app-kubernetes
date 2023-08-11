terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.66.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "terrraformRG"
      storage_account_name = "staccterraformstate"
      container_name       = "core-tfstate"
      key                  = "terraform.tfstate"
  }

}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "voting-app-rg"{
    name = "voting-app-rg"
    location = "East US"
}

resource "azurerm_container_registry" "votingAppRegistry08" {
  name                = "votingAppRegistry08"
  resource_group_name = "voting-app-rg"
  location            = "East US"
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "votingApp-aks"
  location            = "East US"
  resource_group_name = "voting-app-rg"
  dns_prefix          = "votingappakscluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

}