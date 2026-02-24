#!/usr/bin/env bash

# Set up an upstream proxy for the repository created in the previous step. This will allow you to cache and proxy packages from the Python Package Index (PyPI).
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export REPO_NAME="assessment-repo" # You can change the repository name as needed

# Function to set up upstream proxy
set_upstream() {
  curl -sS\
    --request POST \
    --url https://api.cloudsmith.io/repos/${NAMESPACE}/${REPO_NAME}/upstream/python/ \
    --header "X-Api-Key: ${API_KEY}" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --data '
{
  "auth_mode": "None",
  "mode": "Cache and Proxy",
  "trust_level": "Trusted",
  "verify_ssl": true,
  "priority": 1,
  "name": "python proxy",
  "is_active": true,
  "upstream_url": "https://pypi.org"
}
' | jq
}

echo "#### Setting up an upstream repository for ${REPO_NAME} in namespace: ${NAMESPACE} ####"
set_upstream