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
  net-tools


curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
nvm install node


npm install -g \
  caniuse-cmd
