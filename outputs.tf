output "Azure_AKS" {
  value = <<README

  Run the following az commands:
  $ az login
  $ az account set --subscription <ID>
  ${format("$ az aks get-credentials --resource-group %s --name %s", azurerm_resource_group.k8sexample.name, azurerm_kubernetes_cluster.k8sexample.name )}

README
}

output "k8s_endpoint" {
  value = "${azurerm_kubernetes_cluster.k8sexample.fqdn}"
}
