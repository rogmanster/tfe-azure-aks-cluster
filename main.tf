provider "azurerm" {
  features {}
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
}

# Azure Resource Group
resource "azurerm_resource_group" "k8sexample" {
  name     = var.resource_group_name
  location = var.azure_location
}

# Azure Security Group
resource "azurerm_network_security_group" "tf-guide-sg" {
  name                = "${var.environment}-sg"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.k8sexample.name

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Consul"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8500"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Azure Container Service (AKS) Cluster
resource "azurerm_kubernetes_cluster" "k8sexample" {
  name = "${var.environment}-k8sexample-cluster"
  location = azurerm_resource_group.k8sexample.location
  resource_group_name = azurerm_resource_group.k8sexample.name
  dns_prefix = var.dns_prefix

  linux_profile {
    admin_username = var.admin_user
    ssh_key {
      key_data = "${chomp(tls_private_key.ssh_key.public_key_openssh)}"
    }
  }

  default_node_pool {
    name        = var.agent_pool_name
    node_count  =  var.agent_count
    os_disk_size_gb = var.os_disk_size
    vm_size     = var.vm_size
  }

  service_principal {
    client_id     = var.ARM_CLIENT_ID
    client_secret = var.ARM_CLIENT_SECRET
  }

  tags = {
    Environment = var.environment
  }
}
