#!/usr/bin/env bash

# Remove tags from an existing package in the repository
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="example_repo_through_cli" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export PKG_IDENTIFIER="csm-cloudsmith-npm-cli-example-101tgz-zunq" # Replace with the intended package identifier

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
                "kk"
              ]
            }
' | jq
}

echo -e "\033[35m# Removing tags from an existing package '${PKG_IDENTIFIER}' in repository '${REPO_NAME}'.\033[0m"
remove_tags