#!/usr/bin/env bash

export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY       # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export REPO_NAME="api-assessment-repoo"       # You can change the repository name as needed
export REPO_DESC="This repository is created for API assessment purposes." # You can change the repository description as needed

# function to create a repository with response recorded in output.txt
create_repo() {
  curl -sS\
    --request POST \
    --url "https://api.cloudsmith.io/repos/${NAMESPACE}/" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '{
    "name": "'"${REPO_NAME}"'",
    "description": "'"${REPO_DESC}"'",
    "repository_type_str": "Public",
    "default_privilege": "Read"
    }' | jq '.' > output.txt 2>&1
}

# Create a new repository
echo "#### Creating a new repository: '${REPO_NAME}' in namespace: '${NAMESPACE}' ####"
create_repo