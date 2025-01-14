resource "azurerm_container_group" "automation" {
  name                = "automation"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_address_type     = "Private"
  subnet_ids          = [module.avm-res-network-virtualnetwork.subnets["aci"].resource_id]
  os_type             = "Linux"

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

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }
}