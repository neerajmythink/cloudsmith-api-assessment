#!/usr/bin/env bash

# Upload a new python package to the existing repository
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="test-repo-2" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export PKG_PATH="your-package-name-1.0.1.whl" # Path to your package file, change as needed

# Function to upload the package to the repository in raw format
upload_raw_package() {
  curl -sS\
    --request PUT \
    --url "https://upload.cloudsmith.io/${NAMESPACE}/${REPO_NAME}/${PKG_PATH}/" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --form "package_file=@${PKG_PATH}" \
    | jq -r '.identifier'
}

export IDENTIFIER=$(upload_raw_package)
echo "# Step 1: Raw package upload ID: $IDENTIFIER"

upload_package() {
  curl -sS\
     --request POST \
     --url "https://api.cloudsmith.io/v1/packages/${NAMESPACE}/${REPO_NAME}/upload/python/" \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --header "X-Api-Key: ${API_KEY}" \
     --data '
{
    "package_file": "'"${IDENTIFIER}"'"
}
' | jq '.'
}

export UPLOAD_PACKAGE=$(upload_package)
echo "# Step 2: Final package upload response: $UPLOAD_PACKAGE"
