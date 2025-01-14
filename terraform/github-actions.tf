// Set env vars for GitHub Actions
resource "github_actions_variable" "acr_repository_name" {
  repository    = "azure-base-network"
  variable_name = "AZURE_ACR_NAME"
  value         = azurerm_container_registry.acr.name
}

resource "github_actions_variable" "acr_login_server" {
  repository    = "azure-base-network"
  variable_name = "AZURE_ACR_LOGIN_SERVER"
  value         = azurerm_container_registry.acr.login_server
}

data "github_actions_registration_token" "default" {
  repository = "azure-base-network"
}