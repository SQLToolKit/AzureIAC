
## Providers list

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.32.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "d3cb5784-4f48-4bdf-8d70-71ea6076ed2e"
  tenant_id       = "77467c9a-a2f9-4f94-833a-d99b1cb48cfb"
}
