#!/bin/bash
echo -ne '\nName: ' && read name
echo -ne '\nEmail: ' && read email
echo ''

mkdir ~/Workspace
ln -s ~/Workspace ~/w

sudo echo 'America/Sao_Paulo' > /etc/timezone

sudo apt-get install zsh git wget curl apt-transport-https tmux -y

zsh
chsh -s $(which zsh)
sudo chsh -s $(which zsh)

# dotfiles
wget -NP /tmp http://is.gd/ENw5aL && source /tmp/ENw5aL

git clone https://github.com/powerline/fonts.git ~/fonts
source ~/fonts/install.sh

wget -NP /tmp https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sed -i.bak '/env zsh/d' /tmp/install.sh
source /tmp/install.sh
sed -i.bak 's/export\ PATH="/export\ PATH="$PATH:/' ~/.zshrc

echo -e "\nexport NAME=\"$name\"" >> ~/.zshrc
echo -e "export EMAIL=\"$email\"" >> ~/.zshrc

git config --global user.name "$name"
git config --global user.email "$email"

ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa -N ''

git clone https://github.com/dracula/zsh.git ~/dracula_zsh
ln -s ~/dracula_zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
sed -i.bak 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1dracula\2~' ~/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/zsh-syntax-highlighting
echo -e '\nsource ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo echo -e "\ndeb http://dl.google.com/linux/deb/ stable main" >> /etc/apt/sources.list

sudo add-apt-repository ppa:webupd8team/java -y

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

sudo apt-get update -y
sudo apt-get install aptitude -y
sudo aptitude update -y

echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | \
    sudo /usr/bin/debconf-set-selections
echo 'mysql-server mysql-server/root_password password root' | \
    sudo /usr/bin/debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | \
    sudo /usr/bin/debconf-set-selections

sudo aptitude install build-essential python-dev python3-dev python-setuptools python3-setuptools \
    python-pip python3-pip ipython ipython3 tree exuberant-ctags nginx postgresql nodejs \
    golang-go.tools redis-server tig python-pip python3-pip ntp p7zip xclip spotify-client \
    p7zip-full p7zip-rar lzma lzma-dev vim vim-nox indicator-keylock rabbitmq-server \
    ruby pgadmin3 htop sqlite3 libsqlite3-dev oracle-java8-installer oracle-java8-set-default \
    mysql-server libmysqlclient-dev mysql-client mysql-workbench mysql-workbench-data filezilla \
    firefox google-chrome-stable postgresql-contrib golang ruby-dev libpq-dev neofetch net-tools \
    ngrok-client unity-control-center -y

sudo pip2 install -U pip setuptools
sudo pip2 install -U virtualenv virtualenvwrapper flake8 ipdb httpie argparse

sudo pip3 install -U pip setuptools
sudo pip3 install -U flake8 ipdb argparse

sudo rabbitmq-plugins enable rabbitmq_management

echo -e '\nexport WORKON_HOME=$HOME/.virtualenvs' >> ~/.zshrc
echo -e 'export PROJECT_HOME=$HOME/Workspace' >> ~/.zshrc
echo -e 'source /usr/local/bin/virtualenvwrapper_lazy.sh' >> ~/.zshrc

\curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
rvm use current --default
gem install rubocop

echo -e '\nsource $HOME/.rvm/scripts/rvm' >> ~/.zshrc

echo -e '\nif [ -f ~/.zsh_aliases ]; then' >> ~/.zshrc
echo -e '    . ~/.zsh_aliases' >> ~/.zshrc
echo -e 'fi' >> ~/.zshrc

echo -e '\nif [ -f ~/.zsh_functions ]; then' >> ~/.zshrc
echo -e '    . ~/.zsh_functions' >> ~/.zshrc
echo -e 'fi' >> ~/.zshrc

echo -e '\nif [ -f ~/.zsh_work ]; then' >> ~/.zshrc
echo -e '    . ~/.zsh_work' >> ~/.zshrc
echo -e 'fi' >> ~/.zshrc

# Vim IDE
wget -NP /tmp http://is.gd/H4WYUh && source /tmp/H4WYUh

# Updater
wget -NP /tmp http://is.gd/yDgV6m && source /tmp/yDgV6m
source ~/updater.sh

source ~/.zshrc
