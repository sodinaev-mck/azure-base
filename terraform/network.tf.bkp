module "avm-res-network-virtualnetwork" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  name                = "myVNet"
  resource_group_name = azurerm_resource_group.main.name
  subnets = {
    "aci" = {
      name             = "aci"
      address_prefixes = ["10.0.0.0/24"]
      delegation = [
        {
          name = "aciDelegation"
          service_delegation = {
            name = "Microsoft.ContainerInstance/containerGroups"
          }
        }
      ]
    }

  }
  enable_telemetry = false

}