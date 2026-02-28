#!/usr/bin/env bash

# List all packages in a given repository  

export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="api-assessment-repo" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key

# Function to list all packages in the repository
list_packages() {
  curl -sS\
     --request GET \
     --url "https://api.cloudsmith.io/packages/${NAMESPACE}/${REPO_NAME}/?sort=-date" \
     --header "X-Api-Key: ${API_KEY}" \
     --header 'accept: application/json' | jq '.[]' | jq -r '.slug + " - " + .slug_perm + " - " + .subtype'
}

echo -e "\033[1;35m# Listing all packages in repository '${REPO_NAME}' in namespace: '${NAMESPACE}' with the following details:\033[0m"
echo -e "\033[1;36mPkg_Name - slug_perm - Type\033[0m"
list_packages