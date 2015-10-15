#!/usr/bin/env bash

# Install command-line tools using Homebrew.
# Also install some node and ruby packages.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#
# Homebrew
#

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php55 --with-gmp
brwe install vim

# Install other useful binaries.
brew install ack
brew install the_silver_searcher
brew install git
brew install imagemagick --with-webp
brew install lua
brew install rename
brew install speedtest_cli
brew install tree
brew install pup
brew install ccat
brew install youtube-dl
brew install watchman

# Install node version manager.
# See Node section below.
brew install nvm

# Install Rbenv for managing Ruby versions.
# See Ruby section below.
brew install rbenv ruby-build

# Remove outdated versions from the cellar.
brew cleanup

#
# Homebrew Cask to install binaries
#

brew install caskroom/cask/brew-cask
brew cask install \
  toggldesktop \
  tunnelbear \
  firefox \
  spotify \
  skype \
  vlc \
  spectacle \
  debookee \
  atom \
  seil \
  owncloud \
  libreoffice \
  google-chrome \
  the-unarchiver \
  recordit \
  elm-platform

#
# Node Packages
#

# Add NVM's working directory to your $HOME path (if it doesn't exist):
mkdir ~/.nvm
# Copy nvm-exec to NVM's working directory
cp $(brew --prefix nvm)/nvm-exec ~/.nvm/
nvm install node
nvm alias default node

npm install -g \
  trash \
  autoless \
  elm-oracle \
  spot


#
# Ruby Gems
#

rbenv install 2.2.2
rbenv global 2.2.2
gem install bundler
