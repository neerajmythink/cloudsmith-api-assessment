#!/usr/bin/env bash

# List all packages in a given repository  

export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="assessment-repo" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key

# Function to list all packages in the repository
list_packages() {
  curl -sS\
     --request GET \
     --url "https://api.cloudsmith.io/packages/${NAMESPACE}/${REPO_NAME}/?sort=-date" \
     --header "X-Api-Key: ${API_KEY}" \
     --header 'accept: application/json' | jq '.[]' | jq '.slug'
}
echo "#### Listing all packages in '${REPO_NAME}' in namespace: '${NAMESPACE}' ####"
list_packages