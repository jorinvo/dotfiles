[ -n "$PS1" ] && source ~/.bash_profile;

export NVM_DIR="/home/jorin/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# added by travis gem
[ -f /home/jorin/.travis/travis.sh ] && source /home/jorin/.travis/travis.sh
