#!/usr/bin/env bash

# Upload a new package to the existing repository 

export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="api-assessment-repo" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export PKG_PATH="your-package-name-1.0.0.whl" # Path to your package file, change as needed

# Packages Validate Upload Python with status code 200 for successful validation, 400 for failed validation
curl -sS\
  --write-out "%{http_code}" \
  --request POST \
  --url "https://api.cloudsmith.io/v1/packages/${NAMESPACE}/${REPO_NAME}/validate-upload/python/" \
  --header 'accept: application/json' \
  --header 'content-type: application/json' \
  --header "X-Api-Key: ${API_KEY}" \
  --data '
{
    "package_file": "'"${PKG_PATH}"'",
    "republish": true,
    "tags": "python"
}
' | jq
