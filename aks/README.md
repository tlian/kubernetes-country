# Azure Kubernetes Service via Terraform

This module will quickly spin up a simple AKS cluster.
The only required argument is a name for resource group in Azure.
All other were set some default values which all can be changed to any arbitrary value.

## Pre-requisite
 - Install Azure CLI

   On MacOs:  ```brew install azure-cli```
 - Install kubectl

   On MacOs: ```brew install kubectl```

### Example
```
git clone https://github.com/tlian/k8s-datadog-monitoring
cd k8s-datadog-monitoring/aks
az login
terraform init
terraform plan
terraform apply -auto-approve
```
Once Terraform applied successfully, there will be an output which is required to set up authentication with the newly spinned up AKS cluster.
The output will look something like
```
az aks get-credentials --name <NAME-OF-AKS-CLUSTER> --resource-group <NAME-OF-RESOURCE-GROUP>
```
Run the above command once and it should all set up.
> Warning: Make sure ~/.kube/config file exist. If not, do ```touch ~/.kube/config```

To verify
```
kubectl get namespaces
```
