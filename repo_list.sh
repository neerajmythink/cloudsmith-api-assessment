#!/usr/bin/env bash

export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key

get_repo_list() {
  curl -sS \
    --request GET \
    --url "https://api.cloudsmith.io/v1/repos/${NAMESPACE}/?sort=-created_at" \
    --header 'accept: application/json' \
    --header "X-Api-Key: ${API_KEY}" | jq '.[]' | jq -r '.created_at + " - " + (.is_private | tostring) + " - " + .name'
}

# Print the echo statement in pink color
echo -e "\033[35m#### Fetching repositories in namespace: ${NAMESPACE} ####\033[0m"
echo -e "\033[36mCreated At - Is Private - Name\033[0m"
REPOS=$(get_repo_list)
echo "$REPOS"
