# cloudsmith-assessment

this repo contains the shell scripts to perform the API assessment for cloudsmith. The scripts are designed to interact with the Cloudsmith API to perform various operations such as listing repositories, creating repositories, and listing vulnerability scan results. Each script is self-contained and can be executed independently to achieve specific tasks related to the Cloudsmith API. The scripts utilize environment variables for configuration, making it easy to customize and reuse them across different environments.

# pre-requisites

- Ensure you have `curl` and `jq` installed on your system to run the scripts
- Set the `CLOUDSMITH_API_KEY` environment variable with your Cloudsmith API key
- Update the `NAMESPACE` and `REPO_NAME` variables in the scripts as needed

# Usage

To run the scripts, navigate to the directory containing the scripts and execute them using the command line. For example:

- To list repositories: `./repo_list.sh`
- To create a repository: `./repo_create.sh`
- To update a repository: `./repo_update.sh`
- To create a entitlement: `./repo_create_entit-tk.sh`
- To create a webhook: `./repo_webhook_create.sh`
- To list webhooks: `./repo_webhook_list.sh`
- To
