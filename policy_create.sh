#!/usr/bin/env bash

# Create a policy for existing namespace
export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key

# Function to create a policy for an namespace
create_policy() {
  curl -sS\
     --request POST \
     --url https://api.cloudsmith.io/orgs/${NAMESPACE}/license-policy/ \
     --header "X-Api-Key: ${API_KEY}" \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data '
{
  "allow_unknown_licenses": false,
  "description": "This is a policy to quarantine packages with unknown licenses.",
  "name": "Quarantine Unknown Licenses",
  "on_violation_quarantine": true,
  "spdx_identifiers": [
	  "Aladdin",
    "MIT"
  ]
}
' | jq
}

echo "#### Creating a policy for namespace: '${NAMESPACE}' with name as 'Quarantine Unknown Licenses' ####"
create_policy