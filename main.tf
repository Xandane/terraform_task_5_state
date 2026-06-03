terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "tfstate"
    storage_account_name  = "tfstorage2003"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
    use_oidc = true
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name     = "tfstate"
}

data "azurerm_storage_account" "sa" {
  name                     = "tfstorage2003"
  resource_group_name      = data.azurerm_resource_group.rg.name
}

data "azurerm_storage_container" "sc" {
  name                 = "tfstate"
  storage_account_name = "tfstorage2003"
}
