#!/usr/bin/env bash

# Script to list the webhooks for the given repository.
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export REPO_NAME="example_repo_through_cli" # You can change the repository name as needed

# Function to set up a webhook for npm packages
get_webhook() {
  curl -sS\
    --request GET \
    --url https://api.cloudsmith.io/webhooks/${NAMESPACE}/${REPO_NAME}/ \
    --header "X-Api-Key: ${API_KEY}" \
    --header 'accept: application/json' | jq '.[]' | jq '.slug_perm + " - " + .created_at + " - " + .created_by'
}

# print echo statement to indicate the start of the webhook listing process in pink color
echo -e "\033[35m#### Getting list of webhook 'slug_perm' for given repo '${REPO_NAME}' in namespace: '${NAMESPACE}' ####\033[0m"
echo 'slug_perm - created_at - created_by'
get_webhook