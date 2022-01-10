function install_pkg(){
    sudo apt update -y
    sudo apt install jq qemu binfmt-support qemu-user-static -y
}

function init_earthly(){
    if ! command -v earthly >/dev/null 2>&1; then
        sudo wget -q -O /usr/local/bin/earthly $(curl -sL https://api.github.com/repos/earthly/earthly/releases/latest \
            | jq -r '.assets[].browser_download_url' | grep earthly-linux-amd64)
        sudo chmod +x /usr/local/bin/earthly
    fi
}

export DATE_TAG=$(date "+%Y%m%d%H%M%S")
