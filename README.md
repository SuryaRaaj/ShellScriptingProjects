# GitHub Repo User Access Script

## Overview

This Bash script retrieves the list of users who have read access to a specified repository within a GitHub organization. It uses the GitHub API to fetch this information and requires that a GitHub username and personal access token be set as environment variables.

## Features

- Lists users with read access to a specified GitHub repository.
- Requires GitHub API credentials to function.
- Outputs the list of users directly to the terminal.

## Prerequisites

Before running the script, ensure that the following tools are installed on your system:

- `curl` - For making HTTP requests.
- `jq` - For parsing JSON data.

