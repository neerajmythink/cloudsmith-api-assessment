#!/usr/bin/env bash

# Create a new entitlement token in a repository with EULA acceptance is required for this token and only supports 2 downloads.
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export REPO_NAME="assessment-repo" # You can change the repository name as needed
export TOKEN_NAME="custom-ET" # Name for the entitlement token
export DOWNLOAD_LIMIT=2 # Set the download limit for the entitlement token

# Function to create an entitlement token
create_entitlement_token() {
  curl -sS\
    --request POST \
    --url "https://api.cloudsmith.io/entitlements/${NAMESPACE}/${REPO_NAME}/?show_tokens=True" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '
  {
    "name": "'${TOKEN_NAME}'",
    "limit_num_downloads": '"${DOWNLOAD_LIMIT}"',
    "is_active": true,
    "eula_required": true,
    "scheduled_reset_period": "Never Reset"
  }
  '| jq '.' | jq '.token'
}

echo "#### Creating an entitlement token for repository: ${REPO_NAME} in namespace: ${NAMESPACE} ####"
create_entitlement_token