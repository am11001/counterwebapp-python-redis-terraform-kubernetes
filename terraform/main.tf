terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.90.0"
    }

  }
}

provider "azurerm" {
  features {
  }
}




resource "azurerm_resource_group" "rg" {
  name     = "${var.base_name}-rg"
  location = var.location
}



#resource "azurerm_container_registry" "acr" {
#  name                = "${var.base_name}acr"
#  resource_group_name = azurerm_resource_group.rg.name
#  location            = azurerm_resource_group.rg.location
#  sku                 = "Basic"
#  admin_enabled       = true
#}

# - - - - -- - - - - -
# Docker
#- - - - - - - -- -

#locals {
#  tagged-name = "${azurerm_container_registry.acr.name}/${var.base_name}-di:${var.tag-name}"
#}
#
#resource "null_resource" "acr_build" {
#  triggers = {
#    dir_sha1   = sha1(join("", [for f in fileset(path.module, "app/*") : filesha1(f)]))
#    image-name = local.tagged-name
#  }
#  #az acr login —name ${azurerm_container_registry.acr.name} --username ${azurerm_container_registry.acr.admin_username} --password ${azurerm_container_registry.acr.admin_password}
#  provisioner "local-exec" {
#    command = <<-EOT
#      
#      az acr build --registry ${azurerm_container_registry.acr.name} --image ${local.tagged-name} ${path.module}/app
#    EOT
#  }
#
#  depends_on = [azurerm_container_registry.acr]
#}


# - - - - -- - - - - -
# AKS
#- - - - - - - -- -

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.base_name}-aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.base_name}-dns"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      kubernetes_version,
      tags
    ]
  }
}

## Node Pool 1
#resource "azurerm_kubernetes_cluster_node_pool" "node_pool1" {
#  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#  name                  = var.node_pool1_name
#  node_count            = var.node_count
#  vm_size               = var.vm_size
#  node_labels = {
#    pool = "frontend"
#  }
#  depends_on = [azurerm_kubernetes_cluster.aks]
#}
#
#resource "azurerm_kubernetes_cluster_node_pool" "node_pool2" {
#  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#  name                  = var.node_pool2_name
#  node_count            = var.node_count
#  vm_size               = var.vm_size
#  node_labels = {
#    pool = "backend"
#  }
#
#  depends_on = [azurerm_kubernetes_cluster.aks]
#}

#resource "azurerm_role_assignment" "ra" {
#  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
#  role_definition_name             = "AcrPull"
#  scope                            = azurerm_container_registry.acr.id
#  skip_service_principal_aad_check = true
#}

resource "local_file" "kubeconfig" {
  filename = "./files/kubeconfig"
  content  = azurerm_kubernetes_cluster.aks.kube_config_raw

  depends_on = [azurerm_kubernetes_cluster.aks]
}