sudo add-apt-repository ppa:webupd8team/atom
sudo add-apt-repository ppa:kilian/f.lux
sudo add-apt-repository ppa:webupd8team/tor-browser
sudo add-apt-repository ppa:numix/ppa
sudo add-apt-repository ppa:neovim-ppa/unstable

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list


sudo apt-get update

sudo apt-get install \
  git \
  atom \
  curl \
  postgresql-9.3 \
  chromium-browser \
  owncloud-client \
  trash-cli \
  xclip \
  spotify-client \
  fluxgui \
  tree \
  youtube-dl \
  silversearcher-ag \
  tor-browser \
  numix-gtk-theme \
  network-manager-openvpn  \
  owncloud-client \
  rbenv ruby-build  \
  cloc \
  nmap \
  net-tools \
  neovim \
  build-essential \
  cmake \
  mosh

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
nvm install node


npm install -g \
  caniuse-cmd \
  tldr

# Neovim
sudo apt-get install python-dev python-pip python3-dev python3-pip
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
