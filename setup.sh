sudo add-apt-repository ppa:kilian/f.lux
sudo add-apt-repository ppa:webupd8team/tor-browser
sudo add-apt-repository ppa:numix/ppa
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo add-apt-repository ppa:webupd8team/java

# Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Owncloud client
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_16.04/ /' >> /etc/apt/sources.list.d/owncloud-client.list"

apt update

apt install git
apt install curl
apt install postgresql-9.3
apt install chromium-browser
apt install spotify-client
apt install fluxgui
apt install tree
apt install youtube-dl
apt install silversearcher-ag
apt install tor-browser
apt install numix-gtk-theme
apt install network-manager-openvpn
apt install owncloud-client
apt install cloc
apt install nmap
apt install net-tools
apt install neovim
apt install build-essential
apt install cmake
apt install jq
apt install golang
apt install mercurial
apt install filezilla
apt install slack-desktop
apt install thunderbird
apt install ffmpeg
apt install xclip
apt install numix-icon-theme-shine
apt install trash-cli


# Node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
nvm install node

npm i -g caniuse-cmd
npm i -g standard


# Neovim
test -d ~/.vim || mkdir ~/.vim

if [ ! -d ~/.config/nvim ]
then
  ln -s ~/.vim ~/.config/nvim
  ln -s ~/.vimrc ~/.config/nvim/init.vim
  ln -s /usr/share/vim/vim74/spell/ ~/.config/nvim/
fi

# vim-plug
if [ ! -e ~/.config/nvim/autoload/plug.vim ]
then
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim -c "PlugInstall"
  # YouCompleteMe
  pip install --user neovim
  cd ~/.config/nvim/plugged/YouCompleteMe && ./install.py --tern-completer
fi


# Ruby with rbenv (apt version is outdated)
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
# ruby version 2.3.0 as default
./bin/rbenv install 2.3.0
./bin/rbenv global 2.3.0
# Bundler
gem install bundler

# Go tools
go get github.com/spf13/hugo
go get github.com/ericchiang/pup


echo 'Manually need to install Python Conda, Telegram'


