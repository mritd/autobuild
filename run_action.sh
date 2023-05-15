#!/usr/bin/env bash

set -e

# GitHub账户用户名
USERNAME="mritd"
# GitHub仓库名
REPO_NAME="autobuild"
# GitHub Personal Access Token，需要有repo权限
TOKEN="${GITHUB_TOKEN:-}"
# 是否触发alpine action，true表示是，false表示否
TRIGGER_ALPINE="${TRIGGER_ALPINE:false}"


if [ "$TRIGGER_ALPINE" = true ]; then
    # 触发alpine action
    ALPINE_RESPONSE=$(curl -s -X POST -H "Authorization: token $TOKEN" \
        "https://api.github.com/repos/$USERNAME/$REPO_NAME/actions/workflows/alpine.yml/dispatches" \
        -d '{"ref":"main", "inputs": {"trigger": "build"}}')

    if [ -n "$ALPINE_RESPONSE" ]; then
        echo "Alpine workflow triggered: $ALPINE_RESPONSE"
    else
        echo "Alpine workflow triggered with no response"
    fi

    # 等待5秒钟，确保alpine action已经完成
    sleep 5
fi

# 获取除alpine action和.earthly以外的所有workflow的名称和ID
WORKFLOWS=$(curl -s -X GET -H "Authorization: token $TOKEN" \
    "https://api.github.com/repos/$USERNAME/$REPO_NAME/actions/workflows" | \
    jq -r '.workflows[] | select(.path != ".github/workflows/.earthly.yaml" and .name != "mritd/alpine") | "\(.id) \(.name)"')

# 遍历除alpine action和.earthly以外的所有workflow的名称和ID，并触发它们
while read -r workflow_id workflow_name
do
    response=$(curl -s -X POST -H "Authorization: token $TOKEN" \
        "https://api.github.com/repos/$USERNAME/$REPO_NAME/actions/workflows/$workflow_id/dispatches" \
        -d '{"ref":"main", "inputs": {"trigger": "build"}}')
    if [ -n "$response" ]; then
        echo "Workflow $workflow_name ($workflow_id): $response"
    else
        echo "Workflow $workflow_name ($workflow_id) triggered with no response"
    fi
done <<< "$WORKFLOWS"
