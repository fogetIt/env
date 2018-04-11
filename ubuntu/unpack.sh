#!/bin/bash
# @Date:   2017-04-03 21:04:01s
# @Last Modified time: 2018-04-10 18:49:26
echo ${ENV_PASSWORD} | sudo -S echo -e "\033[1;;42m\n\033[0m"


gz_installer() {
    name=$1;package=$2;starter=$3
    [[ $4 ]] && DG_COUNT=$4 || DG_COUNT=0
    if [[ ! -f "/usr/bin/${name}" ]]; then
        if [[ ! -d "/opt/${package}" ]]; then
            cd ${ENV_SOFTWARES}
            if [[ ! -f "./${package}.tar.gz" ]]; then
                echo -e "\033[1;;41m**********Can't find ${name} package!**********\033[0m"
            else
                sudo mkdir "/opt/${package}" \
                && sudo tar -zxvf "${package}.tar.gz" -C "/opt/${package}" --strip-components 1 \
                && [[ ${DG_COUNT} == 0 ]] && let DG_COUNT++ \
                && gz_installer ${name} ${package} ${starter} ${DG_COUNT}
            fi
        else
            sudo ln -sf "/opt/${package}/bin/${starter}" "/usr/bin/${name}" \
            && [[ ${DG_COUNT} == 1 ]] && let DG_COUNT++ \
            && gz_installer ${name} ${package} ${starter} ${DG_COUNT}
        fi
    else
        echo "**********Install ${name} successful!**********"
    fi
}

function jetbrains() {
    name=$1;package=$2;starter=$3;
    gz_installer ${name} ${package} ${starter} \
    && ${name} && (
        cd ${HOME}/.${package}*/config \
        && (
            find ./ -name "keymaps" -type d | grep "keymaps" || mkdir keymaps
            ) \
        && sudo cp -f "${ENV_DIR}/edit/JetBrains.xml" ./keymaps/ \
        && echo "**********Set ${name} keymaps successful!**********"
        ) || echo "**********Install ${name} failed!**********"
}

jetbrains "pycharm"  "PyCharm"  "pycharm.sh"
jetbrains "webstorm" "WebStorm" "webstorm.sh"
jetbrains "goland"   "GoLand"   "goland.sh"
#jetbrains "idea"     "IdeaIU"   "idea.sh"
# ***************************************************************
node -v && npm -v || (
    if [[ ! -d /opt/node ]]; then
        cd ${ENV_SOFTWARES}
        if [[ ! -f "${ENV_SOFTWARES}/node.tar" ]]; then
            if [[ ! -f "${ENV_SOFTWARES}/node.tar.xz" ]]; then
                wget -O "node.tar.xz" \
                    "https://npm.taobao.org/mirrors/node/v8.9.3/node-v8.9.3-linux-x64.tar.xz"
            fi
            xz -d node.tar.xz
        fi
        sudo mkdir /opt/node \
        && sudo tar -xvf node.tar -C /opt/node --strip-components 1
    fi
    [[ $? == 0 ]] \
    && echo "download and uncompress zip package to /opt successful!" \
    && sudo ln -sf /opt/node/bin/node /usr/bin/node \
    && sudo ln -sf /opt/node/bin/npm /usr/bin/npm \
    && echo "create soft link successful!" \
    && npm config set prefix /usr/local
    )
# npm config list
# npm全局命令安装目录：${prefix}/bin/
# ***************************************************************
go version || (
    cd ${ENV_SOFTWARES} \
    && [[ ! -f "./go.tar.gz" ]] \
    && wget -O "go.tar.gz" "https://studygolang.com/dl/golang/go1.9.2.linux-amd64.tar.gz"

    gz_installer "go" "go" "go" \
    && export GOROOT=/opt/go \
    && export GOPATH=${HOME}/gocode \
    && export PATH=$PATH:${GOROOT}/bin:${GOPATH}/bin

    # go 语言安装的路径
    GOROOT='export GOROOT=/opt/go'
    # go 包安装路径（可以指定多个）
    #     src 存放源代码（比如：.go .c .h .s等）
    #     pkg 存放编译时生成的中间文件（比如：.a）
    #     bin 存放编译后生成的可执行文件
    #         为了方便，可以把此目录加入到 PATH
    #         如果有多个目录，那么添加所有的bin目录
    GOPATH='export GOPATH=${HOME}/gocode'
    PATH='export PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin'

    grep ${GOROOT} /etc/profile || tee -e ${GOROOT} \
    && grep ${GOPATH} /etc/profile || tee -e ${GOPATH} \
    && grep ${PATH} /etc/profile || tee -e ${PATH}
)
# ***************************************************************
sudo find ${HOME}/.config/ -name mongobooster | grep mongobooster || (
    cd ${ENV_SOFTWARES} \
    && axel -n 16 "http://s3.mongobooster.com/download/3.5/mongobooster-3.5.5-x86_64.AppImage" \
    && chmod +x ./mongobooster*.AppImage \
    && sudo apt-get install libstdc++6 \
    && ./mongobooster*.AppImage
    )
