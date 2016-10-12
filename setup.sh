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

echo "Setting up system with latest toys ..."


link_dotfile() {
  if [ ! -e ~/.$1 ]
  then
    ln -s $(pwd)/$1 ~/.$1
    echo "Linked ~./$1"
  fi
}

link_dotfile vimrc
link_dotfile bash_profile
link_dotfile bashrc
link_dotfile gitconfig
link_dotfile inputrc
link_dotfile psqlrc

NVIM_CLIENT="/usr/bin/nvim-client"
if [ ! -e $NVIM_CLIENT ]
then
  sudo ln -s $(pwd)/nvim-client $NVIM_CLIENT
  echo "Linked $NVIM_CLIENT"
fi


add_ppa() {
  grep -q "^deb.*$1" /etc/apt/sources.list.d/* \
    || (sudo add-apt-repository -y ppa:$1 \
    && echo "Added repository: $1")
}

# Add external repositories
add_ppa neovim-ppa/unstable
add_ppa nathan-renniewaldock/flux
add_ppa numix/ppa
add_ppa webupd8team/tor-browser


sudo apt-get update
sudo apt-get upgrade --assume-yes

# Basics
sudo apt-get --assume-yes install \
  git \
  curl \
  build-essential \
  cmake \
  tree \
  ffmpeg \
  xsel \
  trash-cli \
  silversearcher-ag \
  cloc \
  postgresql \
  youtube-dl \
  nmap \
  net-tools \
  jq \
  mercurial

# GUIs
sudo apt-get --assume-yes install \
  filezilla \
  thunderbird \
  chromium-browser

# From custom repositories
sudo apt-get --assume-yes install \
  neovim \
  fluxgui \
  numix-gtk-theme \
  numix-icon-theme-circle

# Some cleaning
sudo apt-get autoremove


# nvm
if [ ! -d $NVM_DIR ] || nvm --version | grep -vq $NVM_VERSION
then
  echo "Install nvm $NVM_VERSION"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash
fi

# Node
if ! hash node 2>/dev/null || node -v | grep -vq $NODE_VERSION
then
  echo "Install Node $NODE_VERSION"
  nvm install $NODE_VERSION
fi

# Node deps
npm update -g
npm i -g standard
npm i -g diff-so-fancy
npm i -g jshint
npm i -g tern


# rbenv
if [ ! -d ~/.rbenv ]
then
  echo "Install rbenv"
  # Use rbenv - apt version is outdated
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# Ruby
if ! hash ruby 2>/dev/null || ruby -v | grep -vq $RUBY_VERSION
then
  echo "Install Ruby $RUBY_VERSION"
  rbenv install $RUBY_VERSION
  rbenv global $RUBY_VERSION
  ## Bundler
  gem install bundler
fi


# Go binaries
if ! hash go 2>/dev/null || go version | grep -vq $GO_VERSION
then
  echo "Install Go $GO_VERSION"
  GOURL="https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz"
  wget -q -O - $GOURL | tar -C /usr/local -xzf -
fi

# Go tools
echo "Install Go tools"
go get -u github.com/spf13/hugo
go get -u github.com/ericchiang/pup
go get -u github.com/FiloSottile/gvt
go get -u github.com/kisielk/errcheck


# Neovim
test -d ~/.vim || mkdir ~/.vim
if [ ! -d ~/.config/nvim ]
then
  ln -s ~/.vim ~/.config/nvim
  ln -s ~/.vimrc ~/.config/nvim/init.vim
  ln -s /usr/share/vim/vim74/spell/ ~/.config/nvim/
fi

## vim-plug
if [ ! -e ~/.config/nvim/autoload/plug.vim ]
then
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim -c "PlugInstall"
  #### YouCompleteMe
  pip install --user neovim
  cd ~/.config/nvim/plugged/YouCompleteMe && ./install.py --tern-completer
fi

echo "All good! Enjoy your day human!"
