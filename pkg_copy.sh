#!/usr/bin/env bash

# Copy an existing package to a new repository
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="assessment-repo" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export PKG_IDENTIFIER="csm-cloudsmith-npm-cli-example-10175920498522-cjbb" # Replace with the actual package identifier you want to copy
export DEST_REPO="test-repo-neeraj" # Replace with the name of the destination repository

# Function to copy an existing package to a new repository
copy_package() {
  curl -sS\
     --request POST \
     --url https://api.cloudsmith.io/packages/${NAMESPACE}/${REPO_NAME}/${PKG_IDENTIFIER}/copy/ \
     --header "X-Api-Key: ${API_KEY}" \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data '
{
  "destination": "'${DEST_REPO}'"
}
' | jq '.slug'
}

echo "#### Copying an existing package to a new repository '${DEST_REPO}' from '${REPO_NAME}' with 'slug' as ####."
copy_package