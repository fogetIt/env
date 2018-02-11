#!/bin/bash
# @Date:   2018-01-24 16:09:38
# @Last Modified time: 2018-02-07 09:53:17
echo $ENV_PASSWORD | sudo -S echo -e "\033[1;;42m\n\033[0m"

# themes/icons

# sudo apt-get install gtk2-engines-pixbuf gnome-themes-standard

# sudo add-apt-repository ppa:numix/ppa
# sudo apt-get update
# sudo apt-get install numix-gtk-theme numix-icon-theme-circle -y

# sudo add-apt-repository ppa:snwh/pulp
# sudo apt-get update
# sudo apt-get install paper-icon-theme -y

# sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 90127F5B
# echo "deb http://downloads.sourceforge.net/project/xenlism-wildfire/repo deb/" | sudo tee -a /etc/apt/sources.list
# sudo apt-get update
# sudo apt-get install xenlism-wildfire-icon-theme -y


# 指针
sudo add-apt-repository ppa:noobslab/macbuntu
sudo apt-get update
sudo apt-get install macbuntu-os-icons-lts-v7
sudo apt-get install macbuntu-os-ithemes-lts-v7


# electronic wechat
git clone https://github.com/geeeeeeeeek/electronic-wechat.git \
&& cd electronic-wechat \
&& npm install --registry=https://registry.npm.taobao.org \
&& npm start
: <<'COMMENT'
# pack into an app
npm run build:osx
npm run build:linux
npm run build:win32
npm run build:win64
COMMENT

: <<'COMMENT'
sudo apt-get install libcwidget3v5 aptitude-common aptitude
COMMENT

# [QQ](http://blog.csdn.net/ysy950803/article/details/52958538)
# [下载](https://pan.baidu.com/s/1kV0u7Nh)，密码: 7vit
# 有可能部分中文乱码，但是不影响聊天、使用
# 卸载其它版的`QQ`，顺序安装
sudo apt-get install wine
sudo dpkg -i crossover-15_15.0.3-1_all.deb
sudo dpkg -i crossover-15_15.0.3-1_all-free.deb
sudo apt-get install libgsm1 libgstreamer0.10-0 libgstreamer-plugins-base0.10-0
sudo dpkg -i deepin-crossover-helper_1.0deepin0_all.deb
sudo dpkg -i apps.com.qq.im_8.1.17255deepin11_i386.deb
: 'vim /usr/bin/killqq'
ps aux | grep -v grep | grep wine |cut -c 9-15 | xargs kill
ps aux | grep -v grep | grep QQ |cut -c 9-15 | xargs kill
ps aux | grep -v grep | grep qq |cut -c 9-15 | xargs kill
pkill  plugplay.exe
pkill  explorer.exe
pkill  services.exe


# chorme
sudo apt-get install libindicator7 libappindicator1
sudo dpkg -i google-chorme-*


# markdown编辑器
# https://www.typora.io/#linux
which typora
if [ $? != 0 ]; then
    sudo apt-key adv \
        --keyserver keyserver.ubuntu.com \
        --recv-keys BA300B7755AFCFAE
    sudo add-apt-repository 'deb https://typora.io ./linux/'
    sudo apt-fast update
    sudo apt-fast install typora
fi

# ************************************************************
# ubuntu16.04LTS重启网卡
sudo ifconfig enp5s0 down
sudo ifconfig enp5s0 up


# UFW     Uncomplicated Firewall（简单的防火墙）————iptables的前端
# Gufw    UFW的图形界面前端，Gufw自称是世界上最简单的防火墙

sudo ufw version || (
    apt-get install iptables
    )
# apt-get remove iptables

sudo ufw status
#
# 关闭/开启防火墙
# ufw disable
# ufw enable
#
# 系统启动时自动开启。关闭所有外部对本机的访问，但本机访问外部正常
# ufw default deny
#
# 关闭 ubuntu 防火墙的其余命令
# iptables -P INPUT ACCEPT
# iptables -P FORWARD ACCEPT
# iptables -P OUTPUT ACCEPT
# iptables -F
#
# 开放端口
# sudo ufw allow 80/tcp
#
# iptables -I INPUT -p tcp --dport 80 -j ACCEPT
# iptables-persistent————持久化端口信息
# apt-get install iptables-persistent
# service iptables-persistent save

# 安装gufw
# sudo apt-get install gufw

# *****************************************************************
svn --version --quiet; [ $? != 0 ] \
&& sudo apt-fast -y install subversion