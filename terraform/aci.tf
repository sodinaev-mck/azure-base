resource "azurerm_container_group" "automation" {
  name                = "automation"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_address_type     = "Private"
  subnet_ids          = [module.avm-res-network-virtualnetwork.subnets["aci"].resource_id]
  os_type             = "Linux"


  image_registry_credential {
    server                    = azurerm_container_registry.acr.login_server
    user_assigned_identity_id = azurerm_user_assigned_identity.main.id
  }

  container {
    name   = "tfe-agent"
    image  = "6otw6gwoacr.azurecr.io/tfe-agent:799778cc6dffaaa458e106cf572e8716d4b2e786"
    cpu    = "1"
    memory = "2"
    environment_variables = {
      TFC_AGENT_TOKEN = tfe_agent_token.default.token
      TFC_AGENT_NAME  = "myagent1"
    }
    ports {
      port     = 9998
      protocol = "UDP"
    }
  }

  container {
    name   = "gh-runner"
    image  = "6otw6gwoacr.azurecr.io/gh-runner:953d129c2b6edcdd3e9d79715635b75231e9ee6a"
    cpu    = "1"
    memory = "2"
    environment_variables = {
      GH_RUNNER_NAME   = "myacirunner"
      GH_RUNNER_URL    = "https://github.com/sodinaev-mck/azure-base"
      GH_RUNNER_TOKEN  = data.github_actions_registration_token.default.token
      GH_RUNNER_LABELS = "linux"
    }
    ports {
      port     = 9997
      protocol = "UDP"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }
}