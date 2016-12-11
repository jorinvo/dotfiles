#/usr/bin/env bash

# macOS development setup
#
# Run this script to install and setup basic tools on a machine.
# Or run it to update current setup to latest changes.
# Steal the bits you like and adjust it to your needs.


# Run in dotfiles folder
cd "$(dirname "${BASH_SOURCE}")"
# Needed for nvm
source bashrc
# Cancel on error
set -e


NODE_VERSION="6.3.1"



# Become super user before starting work
sudo -v

printf "\nSetting up system with latest toys ..."


# Enable italic support
tic xterm-256color-italic.terminfo


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

link_dotfile inputrc
link_dotfile bashrc
link_dotfile bash_profile
link_dotfile gitconfig
link_dotfile vimrc
link_dotfile psqlrc
link_dotfile sqliterc
link_to $(pwd)/nvim-client ~/bin/nvim-client
link_to ~/files/ssh/config ~/.ssh/config


printf "\nUpdating macOS\n"
sudo softwareupdate -i -a


# Brew
printf "\nInstalling Brew formulas\n"
brew update
brew upgrade
brew cleanup
# Install all not installed packages from ./brew.txt
comm -23 <(sort brew.txt) <({ brew ls --full-name; brew cask ls | sed -e 's#^#Caskroom/cask/#'; } | sort) | xargs brew install

# Bash Completion
brew tap homebrew/completions
## Golang
curl -s https://raw.githubusercontent.com/skelterjohn/go-pkg-complete/master/go-pkg-complete.bash.inc > $(brew --prefix)/etc/bash_completion.d/go-pkg-complete
chmod +x $(brew --prefix)/etc/bash_completion.d/go-pkg-complete


# Node
if ! hash node 2>/dev/null || node -v | grep -vq $NODE_VERSION
then
  printf "\nInstalling Node $NODE_VERSION"
  nvm install $NODE_VERSION
fi
# NPM packages
printf "\nUpdating npm packages\n"
npm install npm -g
npm update -g


# Go tools
printf "\nInstalling Go tools"
go get -u github.com/FiloSottile/gvt


# Neovim
test -d ~/.vim || mkdir ~/.vim
if [ ! -d ~/.config/nvim ]
then
  ln -s ~/.vim ~/.config/nvim
  ln -s ~/.vimrc ~/.config/nvim/init.vim
  ln -s /usr/share/vim/vim74/spell/ ~/.config/nvim/
  printf "\nLinked Neovim config"
fi

## vim-plug
if [ ! -e ~/.config/nvim/autoload/plug.vim ]
then
  printf "\nInstalling vim-plug"
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  #### YouCompleteMe
  pip install neovim
  cd ~/.config/nvim/plugged/YouCompleteMe && ./install.py --tern-completer
fi
nvim +PlugInstall +PlugUpgrade +PlugUpdate +qall


printf "\nAll good. Enjoy your day human."

