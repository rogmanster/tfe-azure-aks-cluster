variable "resource_group_name" {
  description = "Azure Resource Group Name"
  default = "rc-k8s-resource-group"
}

variable "azure_location" {
  description = "Azure Location, e.g. North Europe"
  default = "WestUS2"
}

variable "dns_prefix" {
  description = "DNS prefix for your cluster"
  default = "rc-k8s"
}

variable "k8s_version" {
  description = "Version of Kubernetes to use"
  default = "1.12.7"
}

variable "admin_user" {
  description = "Administrative username for the VMs"
  default = "azureuser"
}

variable "agent_pool_name" {
  description = "Name of the K8s agent pool"
  default = "default"
}

variable "agent_count" {
  description = "Number of agents to create"
  default = 3
}

variable "vm_size" {
  description = "Azure VM type"
  default = "Standard_D2_V2"
}

variable "os_type" {
  description = "OS type for agents: Windows or Linux"
  default = "Linux"
}

variable "os_disk_size" {
  description = "OS disk size in GB"
  default = "30"
}

variable "environment" {
  description = "value passed to Environment tag and used in name of Vault k8s auth backend in the associated k8s-vault-config workspace - 3"
  default = "aks-dev"
}

variable "type" {
  default = "AvailabilitySet"
}

variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
