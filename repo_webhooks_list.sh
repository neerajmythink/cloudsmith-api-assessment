#!/usr/bin/env bash

# Script to list the webhooks for the given repository.
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export REPO_NAME="assessment-repo" # You can change the repository name as needed

# Function to set up a webhook for npm packages
get_webhook() {
  curl -sS\
    --request GET \
    --url https://api.cloudsmith.io/webhooks/${NAMESPACE}/${REPO_NAME}/ \
    --header "X-Api-Key: ${API_KEY}" \
    --header 'accept: application/json' | jq '.[]' | jq '.slug_perm'
}

echo "#### Getting list of webhook 'slug_prem' for given repo '${REPO_NAME}' in namespace: '${NAMESPACE}' ####"
get_webhook