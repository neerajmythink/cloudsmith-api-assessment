#!/usr/bin/env bash

# Add privileges to the repository.
# Create a Team using API and give Write access to the repository.
# Create a Service account using API and give Admin access to the repository.
# Give current user Admin access to the repository.


export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export REPO_NAME="assessment-repo" # You can change the repository name as needed
export TEAM_NAME="new-team" # Name for the team to be created
export SERVICE_NAME="new-service" # Name for the service account to be created

# function to add team to the namespace
add_team() {
  curl -sS\
    --request POST \
    --url "https://api.cloudsmith.io/orgs/${NAMESPACE}/teams/" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '
            {
              "visibility": "Visible",
              "description": "team created using API",
              "name":"'${TEAM_NAME}'"
            } ' | jq
}

# function to add privileges to team for the repository with write access
add_team_privileges() {
  curl -sS\
    --request PATCH \
    --url https://api.cloudsmith.io/repos/${NAMESPACE}/${REPO_NAME}/privileges \
    --header "X-Api-Key: ${API_KEY}" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --data '
          {
            "privileges": [
              {
                "privilege": "Write",
                "team": "'${TEAM_NAME}'"
              }
            ]
          }
          ' | jq
}

# function to add service account to the namespace
add_service_account() {
  curl -sS\
    --request POST \
    --url https://api.cloudsmith.io/orgs/${NAMESPACE}/services/ \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '
            {
              "description": "service account created using API",
              "name": "'${SERVICE_NAME}'"
            }
            ' | jq -r '.slug'
}

# function to add privileges to the repository for service account
add_service_account_privileges() {
  curl -sS\
    --request PATCH \
    --url https://api.cloudsmith.io/repos/${NAMESPACE}/${REPO_NAME}/privileges \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '
            {
              "privileges": [
                {
                  "privilege": "Admin",
                  "service": "'${SERVICE_ACCOUNT_SLUG}'"
                }
              ]
            }
            '
}

# function to get current user
get_current_user() {
  curl -sS\
      --request GET \
      --url https://api.cloudsmith.io/user/self/ \
      --header "X-Api-Key: ${API_KEY}" \
      --header 'accept: application/json' | jq -r '.slug'
}

# function to add privileges to the repository for current user
update_user_privileges() {
  curl -sS\
      --request PATCH \
      --url https://api.cloudsmith.io/repos/${NAMESPACE}/${REPO_NAME}/privileges \
      --header 'accept: application/json' \
      --header 'content-type: application/json' \
      --header "X-Api-Key: ${API_KEY}" \
      --data '
            {
              "privileges": [
                {
                  "privilege": "Admin",
                  "user": "'${CURRENT_USER}'"
                }
              ]
            }
            '
}

echo "#### Adding a team to the namespace '$NAMESPACE' and giving Write access to '$TEAM_NAME' team for the repository '$REPO_NAME' ####"
add_team
add_team_privileges

echo "#### Adding a service account to the namespace '$NAMESPACE' and giving Admin access to '$SERVICE_NAME' account for the repository '$REPO_NAME' ####"
export SERVICE_ACCOUNT_SLUG=$(add_service_account)
add_service_account_privileges

echo "#### Giving current user Admin access to the repository '$REPO_NAME' of namespace '$NAMESPACE' ####"
export CURRENT_USER=$(get_current_user)
update_user_privileges