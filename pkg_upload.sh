#!/usr/bin/env bash

# Upload a new package to the existing repository 

export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="assessment-repo" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export PKG_PATH="npm_test_file.tgz" # Path to your package file, change as needed

# Function to upload a package to the repository
upload_package() {
  curl -sS\
     --request POST \
     --url https://api.cloudsmith.io/packages/${NAMESPACE}/${REPO_NAME}/upload/npm/ \
     --header "X-Api-Key: ${API_KEY}" \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data '
            {
              "package_file": "@'"${PKG_PATH}"'"
            }
' | jq
}

echo "#### Uploading a package to '${REPO_NAME}' in namespace: '${NAMESPACE}' ####"
upload_package