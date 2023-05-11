#!/usr/bin/env bash

set -e

WORKFLOW_DIR='.github/workflows'

cat > ${WORKFLOW_DIR}/aio.yaml <<EOF
name: All In One

on:
  schedule:
    - cron: 0 16 * * 1
  workflow_dispatch:
    inputs:
      trigger:
        description: Manually trigger
        required: true
        type: choice
        options:
          - build

jobs:
EOF

for name in `ls -d */ | tr -d '/'`; do
   sed "s@REPLACE_NAME@${name}@g" ${WORKFLOW_DIR}/wk.tpl > ${WORKFLOW_DIR}/${name}.yaml
   sed "s@REPLACE_NAME@${name}@g" ${WORKFLOW_DIR}/job.tpl >> ${WORKFLOW_DIR}/aio.yaml
done


