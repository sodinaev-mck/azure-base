resource "random_string" "main" {
  length  = 8
  special = false
}
// create Azure resource group in East US with Terraform
resource "azurerm_resource_group" "main" {
  name     = "sherzod-odinaev-sandbox"
  location = "East US"
}

// create Managed Identity
resource "azurerm_user_assigned_identity" "main" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = "sherzod-odinaev-sandbox-mi"
}

locals {
  mi_roles = ["Reader", "AcrPull"]
}

// grant access to the Managed Identity to the resource group
resource "azurerm_role_assignment" "main" {
  for_each             = toset(local.mi_roles)
  scope                = azurerm_resource_group.main.id
  role_definition_name = each.value
  principal_id         = azurerm_user_assigned_identity.main.principal_id
}
