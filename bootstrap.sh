#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function doIt() {
  ln -sf $(pwd)/vimrc ~/.vimrc;
  ln -sf $(pwd)/aliases ~/.aliases;
  ln -sf $(pwd)/bash_profile ~/.bash_profile;
  ln -sf $(pwd)/bash_prompt ~/.bash_prompt;
  ln -sf $(pwd)/bashrc ~/.bashrc;
  ln -sf $(pwd)/exports ~/.exports;
  ln -sf $(pwd)/functions ~/.functions;
  ln -sf $(pwd)/gitconfig ~/.gitconfig;
  ln -sf $(pwd)/inputrc ~/.inputrc;
  ln -sf $(pwd)/path ~/.path;
  ln -sf $(pwd)/psqlrc ~/.psqlrc;

  if [ -d "$(pwd)/.atom" ]; then
    ln -sf $(pwd)/atom/config.cson ~/.atom/config.cson;
    ln -sf $(pwd)/atom/keymap.cson ~/.atom/keymap.cson;
    ln -sf $(pwd)/atom/styles.less ~/.atom/styles.less;
  else
    echo ".atom directory doesn't exist."
  fi

  source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;

unset doIt;
