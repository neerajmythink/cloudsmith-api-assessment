#!/usr/bin/env bash

# List all policies for an existing namespace
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key

# Function to list policies for an namespace
list_policies() {
  curl -sS\
     --request GET \
     --url https://api.cloudsmith.io/orgs/${NAMESPACE}/license-policy/ \
     --header "X-Api-Key: ${API_KEY}" \
     --header 'accept: application/json' | jq
}

echo "#### Listing policies for namespace: '${NAMESPACE}' ####"
list_policies