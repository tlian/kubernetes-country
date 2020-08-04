# Azure Kubernetes Service via Terraform

This module will quickly spin up a simple AKS cluster.
The only required argument is a name for resource group in Azure.
All other were set some default values which all can be changed to any arbitrary value.

## Pre-requisite
 - Install Azure CLI

   On MacOs:  ```brew install azure-cli```

### Example
```
git clone https://github.com/tlian/k8s-datadog-monitoring
cd k8s-datadog-monitoring/aks
az login
terraform init
terraform plan
terraform apply -auto-approve
```
