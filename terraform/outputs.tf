
#output "azurerm_container_registry_password" {
#  value = nonsensitive(azurerm_container_registry.acr.admin_password)
#  #sensitive   = true
#}
#
#
#output "azurerm_container_registry_url" {
#  value = azurerm_container_registry.acr.login_server
#}
#
#output "azurerm_container_registry_username" {
#  value = azurerm_container_registry.acr.admin_username
#}
#
#output "azurerm_container_registry_name" {
#  value = azurerm_container_registry.acr.name
#}
#
## - - -

#output "app_directory" {
#  value = "${path.module}/app"
#}

#output "image_name" {
#  value = local.tagged-name
#}

#output "image-name" {
#  value = "${azurerm_container_registry.acr.login_server}/${azurerm_container_registry.acr.admin_username}/${local.tagged-name}"
#}



output "fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

