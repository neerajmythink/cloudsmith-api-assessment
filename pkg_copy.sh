#!/usr/bin/env bash

# Copy an existing package to a new repository
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key

export REPO_NAME="example_repo_through_cli" # You can change the repository name as needed
export PKG_IDENTIFIER="cloudsmith_python_native_example-100-py2py3-n-f6hx" # Replace with the actual package identifier you want to copy

export DEST_REPO="qa" # Replace with the name of the destination repository



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

echo -e "\033[35m# Copying an existing package to a new repository '${DEST_REPO}' from '${REPO_NAME}' with 'slug' as '${PKG_IDENTIFIER}' \033[0m"
copy_package