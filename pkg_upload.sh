#!/usr/bin/env bash

# Upload a new npm package to the existing repository 

export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export REPO_NAME="api-assessment-repo" # You can change the repository name as needed
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export PKG_PATH="acorn-8.8.2.tgz" # Path to your package file, change as needed

# Function to MD5 hash of the package file
calculate_md5() {
  if [[ -f "$PKG_PATH" ]]; then
    md5sum "$PKG_PATH" | awk '{ print $1 }'
  else
    echo "Package file not found: $PKG_PATH"
    exit 1
  fi
}
MD5_HASH=$(calculate_md5)
echo "# Step 1: MD5 hash of the package: $MD5_HASH"

# Function to validate package upload for npm with status code 200 for successful validation, 400 for failed validation
validate_package_upload() {
  curl -sS\
    --write-out "%{http_code}" \
    --request POST \
    --url "https://api.cloudsmith.io/v1/packages/${NAMESPACE}/${REPO_NAME}/validate-upload/npm/" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '
  {
      "package_file": "'"${PKG_PATH}"'"
  }
  ' | jq
}
VALIDATE_PACKAGE_UPLOAD_STATUS=$(validate_package_upload)
echo "# Step 2: Package upload validation status: $VALIDATE_PACKAGE_UPLOAD_STATUS"

# Function to upload the package to the repository in raw format
upload_raw_package() {
  curl -sS\
    --request POST \
    --url "https://upload.cloudsmith.io/${NAMESPACE}/${REPO_NAME}/upload/raw/" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '
            {
                "package_file": "'"@${PKG_PATH}"'"
            }
  ' | jq '.upload_id'
}
UPLOAD_RAW_PACKAGE_RESPONSE=$(upload_raw_package)
echo "# Step 3: Raw package upload ID: $UPLOAD_RAW_PACKAGE_RESPONSE"
