data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "require_tag" {
  name         = "require-costcenter-tag-${var.environment}"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require cost-center tag"

  policy_rule = jsonencode({
    if = {
      field  = "tags['cost-center']"
      exists = "false"
    }
    then = {
      effect = "deny"
    }
  })
}

resource "azurerm_policy_assignment" "require_tag" {
  name                 = "assign-require-costcenter-${var.environment}"
  scope                = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.require_tag.id
}