#!/bin/bash

#####################################
# About: This Bash script returns the users who have access to the repos in our organization.
# Input: Username and Token must be exported before executing this file. Organization and Repository names should be given as arguments while executing this script.
#####################################

# GitHub API URL
API_URL="https://api.github.com"

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators=$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Function to check the count of arguments passed
function helper {
    local expected_cmd_arg=2
    if [ $# -ne $expected_cmd_arg ]; then
        echo "Please execute the script with the required command-line arguments."
        exit 1
    fi
}

# Main script

# Check if the correct number of arguments is provided
helper "$@"

# Assign arguments to variables
REPO_OWNER=$1
REPO_NAME=$2

# GitHub username and personal access token (should be exported before running the script)
USERNAME=$username
TOKEN=$token

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
