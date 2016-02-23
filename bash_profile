#!/usr/bin/env bash

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `${PATH}`.
for file in ~/.{bash_prompt,exports,path,aliases,functions}; do
  [ -r "${file}" ] && [ -f "${file}" ] && source "${file}";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "${option}" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  complete -o default -o nospace -F _git g;
fi;

# Completion for https://github.com/zquestz/s
if [ -f ${GOPATH}/src/github.com/zquestz/s/autocomplete/s-completion.bash ]; then
  . ${GOPATH}/src/github.com/zquestz/s/autocomplete/s-completion.bash
fi

# Enable rbenv if it exists
which rbenv &> /dev/null && eval "$(rbenv init -)"

export NVM_DIR="/home/jorin/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"  # This loads nvm

# added by travis gem
[ -f /home/jorin/.travis/travis.sh ] && source /home/jorin/.travis/travis.sh

# Bind Ctrl-x to fg => to go quickly back to vim
bind -x '"\C-x":"fg"'
