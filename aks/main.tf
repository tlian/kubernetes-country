variable "location" {
  type = string
  default = "East US 2"
  description = "Region in Azure such as <East US 2>"
}

variable "resource_group" {
  type = string
  description = "Name of Resource Group to be created in Azure"
}

variable "kluster_name" {
  type = string
  default = "aks-example"
  description = "Name of AKS cluster to be provided in Azure" 
}

variable "dns_prefix" {
  type = string
  default = "aksexample"
  description = "DNS prefix for AKS cluster."
}

variable "kubernetes_version" {
  type = string
  default = "1.17.7"
  description = "Kubernetes version. Must be supported in Azure target Region."
}

# ************************************************************** #
provider "azurerm" {
  version = ">=2.0.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_kubernetes_cluster" "kluster" {
  name                = var.kluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  kubernetes_version  = var.kubernetes_version

  network_profile {
    network_plugin    = "kubenet"
  }

  default_node_pool {
    name                 = "default"
    vm_size              = "Standard_D2s_v3"
    enable_auto_scaling  = true
    min_count            = 1
    max_count            = 5
    node_count           = 1
    availability_zones   = [1,2,3]
  }

  addon_profile {
    kube_dashboard {
      enabled = true
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    projcode = "example"
  }
}

output "aks_login" {
  value = "az aks get-credentials --name ${azurerm_kubernetes_cluster.kluster.name} --resource-group ${azurerm_resource_group.rg.name}"
}

# output "client_certificate" {
#   value = azurerm_kubernetes_cluster.kluster.kube_config.0.client_certificate
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.kluster.kube_config_raw
# }