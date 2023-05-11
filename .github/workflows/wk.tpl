name: mritd/REPLACE_NAME

on:
  workflow_call:
  workflow_dispatch:
    inputs:
      trigger:
        description: Manually trigger
        required: true
        type: choice
        options:
          - build

jobs:
  REPLACE_NAME:
    uses: ./.github/workflows/.earthly.yaml
    secrets: inherit
    with:
      build-dir: REPLACE_NAME
