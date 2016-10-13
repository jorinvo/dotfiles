#/usr/bin/env bash

# Run in dotfiles folder
cd "$(dirname "${BASH_SOURCE}")"
# Needed for nvm
source bashrc
# Cancel on error
set -e



NVM_VERSION="0.31.4"
NODE_VERSION="6.3.1"
RUBY_VERSION="2.3.1"
GO_VERSION="1.7.1"



# Become super user before starting work
sudo -v

printf "\nSetting up system with latest toys ..."


# Create folders
mkdir -p ~/bin ~/projects

# Create Symlinks
link_to() {
  if [ ! -e $2 ]
  then
    ln -s $1 $2
    printf "\nLinked $2"
  fi
}
link_dotfile() {
  link_to $(pwd)/$1 ~/.$1
}

link_dotfile bashrc
link_dotfile bash_profile
link_dotfile gitconfig
link_dotfile inputrc
link_dotfile psqlrc
link_dotfile vimrc
link_to $(pwd)/nvim-client ~/bin/nvim-client
link_to $(pwd)/autostart ~/.config/autostart
link_to ~/syncfiles/ssh_config ~/.ssh/config


# Add repositories
add_ppa() {
  grep -q "^deb.*$1" /etc/apt/sources.list.d/* \
    || (sudo add-apt-repository -y ppa:$1 \
    && printf "\nAdded repository: $1")
}

# Add external repositories
add_ppa nathan-renniewaldock/flux
add_ppa neovim-ppa/unstable
add_ppa numix/ppa

printf "\nUpdating packages\n"

sudo apt-get update
sudo apt-get upgrade --assume-yes

sudo apt-get --assume-yes install \
  build-essential \
  chromium-browser \
  cloc \
  cmake \
  curl \
  ffmpeg \
  filezilla \
  fluxgui \
  git \
  jq \
  mercurial \
  neovim \
  network-manager-openvpn-gnome \
  net-tools \
  nmap \
  numix-gtk-theme \
  numix-icon-theme-circle \
  postgresql \
  silversearcher-ag \
  thunderbird \
  trash-cli \
  tree \
  xsel \
  youtube-dl

# Some cleaning
sudo apt-get autoremove


# nvm
if [ ! -d $NVM_DIR ] || nvm --version | grep -vq $NVM_VERSION
then
  printf "\nInstalling nvm $NVM_VERSION"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash
fi

# Node
if ! hash node 2>/dev/null || node -v | grep -vq $NODE_VERSION
then
  printf "\nInstalling Node $NODE_VERSION"
  nvm install $NODE_VERSION
fi

# npm packages
printf "\nUpdating npm packages\n"
npm update -g
npm i -g diff-so-fancy
npm i -g jshint
npm i -g standard
npm i -g tern


# rbenv
if [ ! -d ~/.rbenv ]
then
  printf "\nInstalling rbenv"
  # Use rbenv - apt version is outdated
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# Ruby
if ! hash ruby 2>/dev/null || ruby -v | grep -vq $RUBY_VERSION
then
  printf "\nInstalling Ruby $RUBY_VERSION"
  rbenv install $RUBY_VERSION
  rbenv global $RUBY_VERSION
  ## Bundler
  gem install bundler
fi


# Go binaries
if ! hash go 2>/dev/null || go version | grep -vq $GO_VERSION
then
  printf "\nInstalling Go $GO_VERSION"
  GOURL="https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz"
  wget -q -O - $GOURL | tar -C /usr/local -xzf -
fi

# Go tools
printf "\nInstalling Go tools"
go get -u github.com/kisielk/errcheck
go get -u github.com/FiloSottile/gvt
go get -u github.com/spf13/hugo
go get -u github.com/ericchiang/pup


# Neovim
test -d ~/.vim || mkdir ~/.vim
if [ ! -d ~/.config/nvim ]
then
  ln -s ~/.vim ~/.config/nvim
  ln -s ~/.vimrc ~/.config/nvim/init.vim
  ln -s /usr/share/vim/vim74/spell/ ~/.config/nvim/
  printf "\nLinked Neovim files"
fi

## vim-plug
if [ ! -e ~/.config/nvim/autoload/plug.vim ]
then
  printf "\nInstalling vim-plug"
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim -c "PlugInstall"
  #### YouCompleteMe
  pip install --user neovim
  cd ~/.config/nvim/plugged/YouCompleteMe && ./install.py --tern-completer
fi


# Tunnelbear
if [ ! -d ~/openvpn ]
then
  printf "\nFetching Tunnelbear config"
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  VPN_URL="https://s3.amazonaws.com/tunnelbear/linux/openvpn.zip"
  TMP_ZIP="/tmp/tb_vpn.zip"
  wget -q -O $TMP_ZIP $VPN_URL
  unzip -d ~ $TMP_ZIP
fi


printf "\nAll good. Enjoy your day human."

