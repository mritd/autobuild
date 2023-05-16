#!/usr/bin/env bash

set -e

REPO="mritd/autobuild"
TOKEN="${GITHUB_TOKEN:-}"

# Get all workflows in the repository
workflows=$(curl -s -H "Authorization: token $TOKEN" "https://api.github.com/repos/$REPO/actions/workflows" | jq -r '.workflows[].id')

# Loop through all workflows and cancel any running jobs
for workflow in $workflows; do
    # Get all jobs for the workflow
    jobs=$(curl -s -H "Authorization: token $TOKEN" "https://api.github.com/repos/$REPO/actions/workflows/$workflow/jobs" | jq -r '.jobs[] | select(.status=="in_progress") | .id')

    # Loop through all jobs and cancel any running jobs
    for job in $jobs; do
        echo "Cancelling job $job in workflow $workflow"
        curl -s -X POST -H "Authorization: token $TOKEN" "https://api.github.com/repos/$REPO/actions/jobs/$job/cancel"
    done
done
