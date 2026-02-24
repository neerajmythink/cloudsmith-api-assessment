#!/usr/bin/env bash

# Remove tags from an existing package in the repository
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="assessment-repo" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export PKG_IDENTIFIER="cloudsmith_python_native_example-100-py2py3-n-c4uo" # Replace with the intended package identifier

# Function to remove tags from an existing package in the repository
remove_tags() {
  curl -sS\
     --request POST \
     --url https://api.cloudsmith.io/packages/${NAMESPACE}/${REPO_NAME}/${PKG_IDENTIFIER}/tag/ \
     --header "X-Api-Key: ${API_KEY}" \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data '
            {
              "action": "Remove",
              "is_immutable": false,
              "tags": [
                "first",
                "added"
              ]
            }
' | jq
}

echo "#### Removing tags from an existing package '${PKG_IDENTIFIER}' in repository '${REPO_NAME}' ####."
remove_tags