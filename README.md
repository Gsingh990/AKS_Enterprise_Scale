# Enterprise-Scale Azure Kubernetes Service (AKS) Cluster

This project provides a comprehensive Terraform solution for deploying an enterprise-grade Azure Kubernetes Service (AKS) cluster. It focuses on high availability, security, and scalability, leveraging best practices for production workloads.

## Architecture Overview

This solution deploys a robust AKS environment, including:

*   **Resource Group:** A dedicated resource group to contain the AKS cluster and its related components.
*   **Networking:** A Virtual Network (VNet) with dedicated subnets for AKS nodes, and associated Network Security Groups (NSGs) for traffic control.
*   **Azure Container Registry (ACR):** A secure, private registry for Docker images.
*   **AKS Cluster:**
    *   **Private Cluster:** The Kubernetes API server is not exposed to the public internet, enhancing security.
    *   **Managed Identity:** Used for AKS cluster and Kubelet identity, simplifying access management.
    *   **Azure CNI:** Provides each pod with an IP address from the VNet, enabling advanced networking scenarios.
    *   **Azure Policy Add-on:** Enforces organizational policies on the cluster.
    *   **Node Pools with Scale Sets:**
        *   **System Node Pool:** For critical system pods.
        *   **User Node Pool(s):** For application workloads, configured with Virtual Machine Scale Sets (VMSS) for auto-scaling.
        *   **Auto-scaling:** Enabled for user node pools to dynamically adjust capacity based on demand.
*   **Monitoring (Hashed Out):** Placeholder for Log Analytics Workspace and AKS monitoring integration.

## Prerequisites

Before deploying this solution, ensure you have the following:

*   **Azure Subscription:** An active Azure subscription.
*   **Azure CLI:** Installed and configured (`az login`).
*   **Terraform:** Installed ([https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)).
*   **Permissions:** Sufficient permissions in your Azure subscription to create resource groups, virtual networks, AKS clusters, and other related resources.

## Deployment Steps

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd aks_enterprise_scale
    ```

2.  **Review and Customize Variables:**
    Open the `variables.tf` and `terraform.tfvars` files in the root directory. Customize the values as needed for your deployment (e.g., resource names, locations, Kubernetes version, VM sizes, node counts).

3.  **Initialize Terraform:**
    ```bash
    terraform init
    ```

4.  **Review the Plan:**
    ```bash
    terraform plan
    ```

5.  **Apply the Changes:**
    ```bash
    terraform apply
    ```

6.  **Verify Deployment:**
    After the deployment completes, verify the created resources in the Azure portal. You should see the AKS cluster, node pools, and associated networking components.

## Configuration

The `variables.tf` and `terraform.tfvars` files are the primary places to customize your deployment. Key variables include:

*   `resource_group_name`: The name of the Azure Resource Group.
*   `location`: The Azure region for resource deployment.
*   `tags`: Global tags to apply to all resources.
*   `vnet_name`, `vnet_address_space`, `aks_subnet_name`, `aks_subnet_address_prefixes`: Networking configuration.
*   `aks_cluster_name`, `kubernetes_version`, `dns_prefix`: AKS cluster basic configuration.
*   `system_node_pool_vm_size`, `system_node_pool_node_count`: System node pool configuration.
*   `user_node_pools`: A map defining multiple user node pools with auto-scaling settings.
*   `private_cluster_enabled`: Enable/disable private cluster.
*   `azure_policy_enabled`: Enable/disable Azure Policy Add-on.
*   `log_analytics_workspace_name` (Temporarily Commented Out): Log Analytics Workspace for monitoring.

## Module Breakdown

*   **`modules/aks_networking/`**: Deploys the Virtual Network, Subnets, and Network Security Groups for the AKS environment.
*   **`modules/aks_cluster/`**: Deploys the AKS cluster itself, including system and user node pools with scale sets, and integrates with networking.
*   **`modules/aks_monitoring/`**: (Temporarily Disabled) Placeholder for Log Analytics Workspace and AKS monitoring integration.

## Important Notes

*   **Private Cluster DNS:** If `private_cluster_enabled` is true, ensure your DNS resolution is correctly configured for the private endpoint of the AKS API server.
*   **Service Principal/Managed Identity:** This setup uses Managed Identity by default, which is recommended. If you need to use a Service Principal, additional configuration would be required.
*   **Azure CNI:** This solution uses Azure CNI. Ensure your subnet has a large enough CIDR block to accommodate the number of pods and nodes you plan to deploy.
*   **Monitoring:** The monitoring module is currently commented out. Uncomment and configure it when you are ready to integrate monitoring.
