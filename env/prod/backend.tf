terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-mgmt"
    storage_account_name = "tfstate844650"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate" # <--- UNIQUE KEY FOR STAGING
  }
}

provider "azurerm" {
  features {}
  
}