#!/usr/bin/env bash

# Schedule a scan for an existing package in the repository 
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="assessment-repo" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export PKG_IDENTIFIER="cloudsmith_python_native_example-100-py2py3-n-5s3z" # Replace with the actual package identifier you want to schedule scan

# Function to schedule a scan for an existing package in the repository
schedule_scan() {
  curl -sS\
     --request POST \
     --url https://api.cloudsmith.io/packages/${NAMESPACE}/${REPO_NAME}/${PKG_IDENTIFIER}/scan/ \
     --header "X-Api-Key: ${API_KEY}" \
     --header 'accept: application/json' | jq '.[]'
}

echo "#### Scheduling a scan for an existing package in repository '${REPO_NAME}' with 'slug' as ####."
schedule_scan