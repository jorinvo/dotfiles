sudo add-apt-repository ppa:neovim-ppa/unstable
sudo add-apt-repository ppa:nathan-renniewaldock/flux
sudo add-apt-repository ppa:numix/ppa
sudo add-apt-repository ppa:webupd8team/java
sudo add-apt-repository ppa:webupd8team/tor-browser

# Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Owncloud client
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_16.04/ /' >> /etc/apt/sources.list.d/owncloud-client.list"

sudo apt update

# Basics
sudo apt install git
sudo apt install curl
sudo apt install build-essential
sudo apt install cmake
sudo apt install tree
sudo apt install ffmpeg
sudo apt install xsel
sudo apt install trash-cli
sudo apt install silversearcher-ag
sudo apt install cloc
sudo apt install postgresql
sudo apt install youtube-dl
sudo apt install nmap
sudo apt install net-tools
sudo apt install jq
sudo apt install golang
sudo apt install mercurial

# GUIs
sudo apt install filezilla
sudo apt install thunderbird
sudo apt install chromium-browser

# From new repos
sudo apt install neovim
sudo apt install owncloud-client
sudo apt install fluxgui
sudo apt install numix-gtk-theme
sudo apt install numix-icon-theme-circle
sudo apt install spotify-client
sudo apt install tor-browser


# Node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.4/install.sh | bash
nvm install node

npm i -g caniuse-cmd
npm i -g standard
npm i -g diff-so-fancy


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


# Ruby with rbenv (apt version is outdated)
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
## ruby version 2.3.1 as default
./bin/rbenv install 2.3.1
./bin/rbenv global 2.3.1
## Bundler
gem install bundler


# Go tools
go get github.com/spf13/hugo
go get github.com/ericchiang/pup


echo 'Manually need to install Python Conda, Telegram'


