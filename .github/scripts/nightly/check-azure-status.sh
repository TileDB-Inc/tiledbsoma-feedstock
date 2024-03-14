#!/bin/bash
set -euo pipefail

# Check status of Azure build. Open Issue if failed
#
# https://learn.microsoft.com/en-us/rest/api/azure/devops/build/status/get
#
# Usage: bash check-azure-status.sh <azure-build-id> <azure-build-name>
#        bash check-azure-status.sh 4 tiledbfeedstock_CI
#
# Requires env var GH_TOKEN with a GitHub token with write-access to Issues

AZURE_ORG="TileDB-Inc"
AZURE_PROJECT="CI"
AZURE_BUILD_ID="$1"
AZURE_BUILD_NAME="$2"
AZURE_BUILD_BRANCH="nightly-build"

echo "Checking status of branch $AZURE_BUILD_BRANCH" \
     "for build $AZURE_BUILD_NAME (id: $AZURE_BUILD_ID) in $AZURE_ORG/$AZURE_PROJECT"

ENDPOINT="https://dev.azure.com/$AZURE_ORG/$AZURE_PROJECT/_apis/build/status/$AZURE_BUILD_NAME?branchName=$AZURE_BUILD_BRANCH"

if curl -sL $ENDPOINT | grep -q succeeded
then
  echo "Build succeeded"
  exit 0
fi

echo "Build failed"
curl -sL $ENDPOINT | tail -n 3

# Open Issue or comment on existing one

theMessage="Nightly feedstock build failure for $AZURE_BUILD_NAME at https://dev.azure.com/$AZURE_ORG/$AZURE_PROJECT/_build?definitionId=$AZURE_BUILD_ID&_a=summary"
echo $theMessage

if [[ -z "$GH_TOKEN" ]]
then
  echo "The env var GH_TOKEN is missing"
  echo "Please define it as a GitHub PAT with write permissions to Issues"
  exit 1
fi

existing=$(gh issue list \
  --label nightly-failure \
  --limit 1 \
  --jq '.[].number' \
  --json "number" \
  --state "open")

if [[ -z "$existing" ]]
then
  echo "Opening new issue"
  gh issue create \
    --assignee "johnkerl,jdblischak" \
    --body "$theMessage" \
    --label "nightly-failure" \
    --title "Nighly feedstock build failed"
else
  echo "Commenting on existing issue"
  gh issue comment "$existing" \
    --body "$theMessage"
fi
