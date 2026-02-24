#!/usr/bin/env bash

# Update Description and Repo type from Public to Private.

export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export REPO_NAME="assessment-repo" # You can change the repository name as needed

# Function to update the repository description and type
update_repo() {
  curl -sS\
    --request PATCH \
    --url "https://api.cloudsmith.io/repos/${NAMESPACE}/${REPO_NAME}/" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '
{
  "description": "This is an updated description for the repository created using cloudsmith API",
  "repository_type_str": "Private"
}
'| jq '.'
}

echo "#### Updating Description and Repo type for repository: ${REPO_NAME} in namespace: ${NAMESPACE} ####"
update_repo