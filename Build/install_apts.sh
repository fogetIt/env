#!/bin/bash
# @Date:   2017-04-01 14:27:49
# @Last Modified time: 2018-02-07 09:52:06
echo ${PASSWORD} | sudo -S echo -e "\033[1;;42m\n\033[0m"

# **************************************************************
# vim        super vi
# vim-tiny   no GUI, only Terminal, light but speed
# vim-gtk    vim with gtk GUI
# vim-gnome  vim with gnome GUI
which vim && vim --version | cat | head -n 2 || (
    sudo apt-fast -y install vim \
    && cp -f ${DIR}/vim/.vimrc ${HOME}/
    )
# sudo apt-fast -y install vim-gtk vim-gnome
[[ ! -d ${SOFTWARES}/plugins ]] \
&& mkdir ${SOFTWARES}/plugins \
&& git clone git@github.com:VundleVim/Vundle.vim.git ${SOFTWARES}/plugins/Vundle
# **************************************************************
which atom && atom -v | cat | head -n 2 || (
    sudo add-apt-repository -y ppa:webupd8team/atom
    sudo apt-fast update
    sudo apt-fast -y install atom
    )
# **************************************************************
mongo --version || sudo apt-fast -y install mongodb-server mongodb-clients

: <<'COMMENT'
$ vim /etc/mongodb.conf
    bind_ip = 0.0.0.0
$ sudo service mongodb stop
$ sudo service mongodb start
$ mongo
COMMENT
# **************************************************************
# sudo vim /etc/mysql/my.cnf
mysql --version || sudo apt-fast -y install mysql-server mysql-client
# **************************************************************
# 处理交互的命令，使之自动化完成
expect -v || sudo apt -y install expect
# ***************************************************************
# beautify ubuntu
sudo apt install docky -y
sudo apt-get install unity-tweak-tool -y
sudo add-apt-repository ppa:noobslab/themes
sudo add-apt-repository ppa:noobslab/icons
sudo apt-get update
sudo apt-get install flatabulous-theme -y
sudo apt-get install ultra-flat-icons -y
# ***************************************************************
zsh --version || sudo apt -y install zsh
# cat /etc/shells
# use oh-my-zsh deploy zsh
[[ ${SHELL} != /usr/bin/zsh ]] \
&& echo ${PASSWORD} | chsh -s `which zsh` \
&& curl -L \
    https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh


# chsh -s $(which bash)
# chsh -s $(which sh)

# vim ~/.zshrc
# ZSH_THEME='random'
# ZSH_THEME='intheloop'
# 编辑-->配置文件首选项
# ***************************************************************
ssh -V || sudo apt-get install openssh-server -y