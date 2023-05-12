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

# 遍历数组并生成 YAML 配置文件内容
yaml_content=$(cat << EOF
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
  ${directories[0]}:
    uses: ./.github/workflows/.earthly.yaml
    secrets: inherit
    with:
      build-dir: ${directories[0]}

EOF
)

# 在第一个代码块的末尾添加一个换行符
yaml_content+=$'\n'

for (( i=0; i<${#directories[@]}; i++ )); do
  if [[ "${directories[$i]}" != "alpine" ]]; then
    yaml_content+="$(cat << EOF
  ${directories[$i]}:
    concurrency: alpine
    needs:
      - ${directories[0]}
    uses: ./.github/workflows/.earthly.yaml
    secrets: inherit
    with:
      build-dir: ${directories[$i]}

EOF
)"
  fi
  # 在每个 YAML 代码块的末尾添加一个换行符
  yaml_content+=$'\n'

  cat > .github/workflows/${directories[$i]}.yaml <<EOF
name: mritd/${directories[$i]}

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
  ${directories[$i]}:
    uses: ./.github/workflows/.earthly.yaml
    secrets: inherit
    with:
      build-dir: ${directories[$i]}
EOF

done

# 将生成的 YAML 内容重定向到一个文件中
echo -e "$yaml_content" > ./.github/workflows/aio.yaml
