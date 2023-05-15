#!/usr/bin/env bash

# 列出当前目录下的所有目录并将它们放入一个数组中
directories=($(ls -d */ | sed 's#/##'))

# 将 "alpine" 移动到数组首位
alpine_index=$(echo "${directories[@]}" | tr ' ' '\n' | grep -n "alpine" | cut -d ":" -f 1)
if [[ $alpine_index != 1 ]]; then
    tmp=${directories[0]}
    directories[0]=${directories[$alpine_index-1]}
    directories[$alpine_index-1]=$tmp
fi

minute="0"
hour="0"
day_of_month="*"
month="*"
day_of_week="1"

for (( i=0; i<${#directories[@]}; i++ )); do
    cat > .github/workflows/${directories[$i]}.yaml <<EOF
name: mritd/${directories[$i]}

on:
  schedule:
    - cron: $minute $hour $day_of_month $month $day_of_week
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
  ${directories[$i]}:
    uses: ./.github/workflows/.earthly.yaml
    secrets: inherit
    with:
      build-dir: ${directories[$i]}
EOF

    hour=$((hour + 1))
    if [ $hour -eq 24 ]; then
        hour=0
        day_of_week=$((day_of_week + 1))
        if [ $day_of_week -eq 8 ]; then
            day_of_week=1
        fi
    fi

done

