#!/usr/bin/env bash

# Schedule a scan for an existing package in the repository 
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="example_repo_through_cli" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export PKG_IDENTIFIER="csm-cloudsmith-npm-cli-example-101tgz-zunq" # Replace with the actual package identifier you want to schedule scan

# Function to schedule a scan for an existing package in the repository
schedule_scan() {
  curl -sS\
     --request POST \
     --url https://api.cloudsmith.io/packages/${NAMESPACE}/${REPO_NAME}/${PKG_IDENTIFIER}/scan/ \
     --header "X-Api-Key: ${API_KEY}" \
     --header 'accept: application/json' | jq '.[]'
}

echo -e "\033[35m# Scheduling a scan for an existing package in repository '${REPO_NAME}' with 'slug' as '${PKG_IDENTIFIER}' \033[0m"
schedule_scan