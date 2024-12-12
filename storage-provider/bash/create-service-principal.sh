#!/bin/bash
# This script requires Azure CLI version 2.25.0 or later. Check version with `az --version`.

# Modify for your environment.
# ACR_NAME: The name of your Azure Container Registry
# SERVICE_PRINCIPAL_NAME: Must be unique within your AD tenant
ACR_NAME=$1
SERVICE_PRINCIPAL_NAME=$2

# Obtain the full registry ID
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query "id" --output tsv)
echo "Working with ACR_REG_ID: $ACR_REGISTRY_ID"

# Check if the service principal already exists
SP_EXISTS=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query "[].appId" --output tsv)

if [ -z "$SP_EXISTS" ]; then
    echo "Service principal does not exist. Creating..."
    PASSWORD=$(az ad sp create-for-rbac \
        --name $SERVICE_PRINCIPAL_NAME \
        --scopes $ACR_REGISTRY_ID \
        --role acrpush \
        --query "password" \
        --output tsv)
    USER_NAME=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query "[].appId" --output tsv)
else
    # SP exists
    echo "Service principal already exists. "
    # USER_NAME=$SP_EXISTS
    # PASSWORD=$(az ad sp credential list --id $SP_EXISTS --query "[0].value" --output tsv)
fi

echo "[$USER_NAME,$PASSWORD]"
