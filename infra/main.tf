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