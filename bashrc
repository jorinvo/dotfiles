#!/usr/bin/env bash

##########
# Prompt #
##########


# Check that terminfo exists before changing TERM var to xterm-256color
# Prevents prompt flashing in Mac OS X 10.6 Terminal.app
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
fi

# Turn off standout; turn off underline
tput sgr 0 0

# Base styles and color palette
# If you want to check color code, run `./testcolor.sh'
BOLD=$(tput bold)
RESET=$(tput sgr0)
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 255)
ORANGE=$(tput setaf 172)

style_user="\[${RESET}${ORANGE}\]"
style_host="\[${RESET}${YELLOW}\]"
style_path="\[${RESET}${GREEN}\]"
style_chars="\[${RESET}${MAGENTA}\]"
style_branch="${CYAN}"
style_jobs="\[${RESET}${YELLOW}\]"

if [[ "${SSH_TTY}" ]]; then
  # connected via ssh
  style_host="\[${BOLD}${RED}\]"
  style_jobs="\[${BOLD}${RED}\]"
elif [[ "$USER" == "root" ]]; then
  # logged in as root
  style_user="\[${BOLD}${RED}\]"
fi

is_git_repo() {
  $(git rev-parse --is-inside-work-tree &> /dev/null)
}

is_git_dir() {
  $(git rev-parse --is-inside-git-dir 2> /dev/null)
}

get_git_branch() {
  local branch_name

  # Get the short symbolic ref
  branch_name=$(git symbolic-ref --quiet --short HEAD 2> /dev/null) ||
  # If HEAD isn't a symbolic ref, get the short SHA
  branch_name=$(git rev-parse --short HEAD 2> /dev/null) ||
  # Otherwise, just give up
  branch_name="(unknown)"

  printf ${branch_name}
}

# Git status information
prompt_git() {
  local git_info git_state uc us ut st

  if ! is_git_repo || is_git_dir; then
    return 1
  fi

  git_info=$(get_git_branch)

  # Check for uncommitted changes in the index
  if ! $(git diff --quiet --ignore-submodules --cached); then
    uc="+"
  fi

  # Check for unstaged changes
  if ! $(git diff-files --quiet --ignore-submodules --); then
    us="!"
  fi

  # Check for untracked files
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    ut="?"
  fi

  # Check for stashed files
  if $(git rev-parse --verify refs/stash &>/dev/null); then
    st="$"
  fi

  git_state=${uc}${us}${ut}${st}

  # Combine the branch name and state information
  if [[ ${git_state} ]]; then
    git_info="${git_info}[${git_state}]"
  fi

  printf "${MAGENTA} on ${style_branch}${git_info}"
}
# Counting background jobs
jobscount() {
  jobs -p | wc -l | bc | awk '{if ($0>0) print " (" $0 ")" }';
}


# Set the terminal title to the current working directory
PS1="\[\033]0;\w\007\]"
# Build the prompt
PS1+="\n" # Newline
PS1+="${style_user}\u" # Username
PS1+="${style_chars}@" # @
PS1+="${style_host}\h" # Host
PS1+="${style_chars}: " # :
PS1+="${style_path}\w" # Working directory
PS1+="\$(prompt_git)" # Git details
PS1+="${style_jobs}\$(jobscount)" # Jobs
PS1+="\n" # Newline
PS1+="${style_chars}\$ \[${RESET}\]" # $ (and reset color)




###########
# Exports #
###########


# Neovim as editor (fall back to Vim)
export EDITOR="$(\
  (which nvim-client &> /dev/null && echo nvim-client) || \
  (which nvim &> /dev/null && echo nvim) || \
  echo vim)"

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768'
export HISTFILESIZE="${HISTSIZE}"
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}"

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'

# Go development
export GOPATH=${HOME}/go

export NVM_DIR="/home/jorin/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"  # This loads nvm




########
# Path #
########


# Include Go installation and local binaries
if [ -n "${GOPATH-}" ]; then
  PATH="${PATH}:/usr/local/go/bin"
  PATH="${PATH}:${GOPATH}/bin"
fi

# on uberpsace
if [ -n "$(hostname | grep uberspace)" ]; then
  # nodejs
  PATH="/package/host/localhost/nodejs-5.1.1/bin:${PATH}"
  #  ruby
  PATH="/package/host/localhost/ruby-2.2.3/bin:${PATH}"
fi

# rbenv if installed manually
if ! which rbenv &> /dev/null && [ -d ${HOME}/.rbenv ]; then
  PATH="${HOME}/.rbenv/bin:${PATH}"
fi

# For python setup
export PATH="/home/jorin/miniconda3/bin:$PATH"





###########
# Aliases #
###########


# Use trash to keep deleting files safely.
alias t=trash

alias ..="c .."
alias ...="c ../.."
alias ....="c ../../.."
alias .....="c ../../../.."
alias ......="c ../../../../.."
alias .......="c ../../../../../.."
alias ........="c ../../../../../../.."
alias .........="c ../../../../../../../.."
alias p="c ~/projects"
alias cdgo='c ~/go/src/github.com/jorinvo'
alias e="${EDITOR}"
alias e.='${EDITOR} .'

alias h=history

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

# List all files colorized
alias l="ls"

# List all files colorized in long format, including dot files
alias la="ls -lhaF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Preserve colors
alias less='less -R'

# Enable aliases to be sudo’ed
alias sudo='sudo '

alias copy="$(which pbcopy &> /dev/null && echo pbcopy || echo 'xclip -sel clip')"

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Recursively delete `.DS_Store` files
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"

# IP addresses
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | copy && echo '=> Public key copied to pasteboard.'"

# Youtube Downloader
alias yt='youtube-dl'
alias yt-audio='youtube-dl --verbose --extract-audio --audio-format "mp3" -o "%(title)s.%(ext)s"'

#git
alias g="git"
alias gd="git diff"
alias ga="git add"
alias gaa="git add --all"
alias gst="git status -sb"
alias gca="git commit -a"
alias gc="git commit"
alias grh="git reset --hard"
alias gbm="git branch --merged"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gba="git branch -a"
alias gl="git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph"
alias gam="git add --all; git commit --amend"
alias clone="git clone"

# also accepts a port as optional argument
alias server='python3 -m http.server'

alias myday='e ~/journal/$(date +%y-%m-%d).md'





#############
# Functions #
#############


#Enter directory and list files
function c() {
  cd "$@" && la
}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_";
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
  local tmpFile="${@%/}.tar";
  tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

  size=$(
    stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
    stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
  );

  local cmd="";
  if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
    # the .tar file is smaller than 50 MB and Zopfli is available; use it
    cmd="zopfli";
  else
    if hash pigz 2> /dev/null; then
      cmd="pigz";
    else
      cmd="gzip";
    fi;
  fi;

  echo "Compressing .tar using \`${cmd}\`…";
  "${cmd}" -v "${tmpFile}" || return 1;
  [ -f "${tmpFile}" ] && rm "${tmpFile}";
  echo "${tmpFile}.gz created successfully.";
}

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
  else
    local arg=-sh;
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@";
  else
    du $arg .[^.]* *;
  fi;
}

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
  function diff() {
    git diff --no-index --color-words "$@";
  }
fi;

# Create a data URL from a file
function dataurl() {
  local mimeType=$(file -b --mime-type "$1");
  if [[ ${mimeType} == text/* ]]; then
    mimeType="${mimeType};charset=utf-8";
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Compare original and gzipped file size
function gz() {
  local origsize=$(wc -c < "$1");
  local gzipsize=$(gzip -c "$1" | wc -c);
  local ratio=$(echo "${gzipsize} * 100 / ${origsize}" | bc -l);
  printf "orig: %d bytes\n" "${origsize}";
  printf "gzip: %d bytes (%2.2f%%)\n" "${gzipsize}" "${ratio}";
}

# Run `dig` and display the most useful info
function digga() {
  dig +nocmd "$1" any +multiline +noall +answer;
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
  perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi;
}

# Get a character’s Unicode code point
function codepoint() {
  perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi;
}

# opens the given location
function o() {
  if [ "$1" = "" ] ; then
    xdg-open .
  else
    xdg-open "$1"
  fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}





###########
# General #
###########


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

# added by travis gem
[ -f /home/jorin/.travis/travis.sh ] && source /home/jorin/.travis/travis.sh
