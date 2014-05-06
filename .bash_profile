# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export PATH=$HOME/bin:$PATH

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

alias light="sudo ~/LightTable/deploy/LightTable"

# prompt colors
# "username@hostname:"
PS1="\e[34;01m\u\e[0m@\e[31;01m\h\e[0m"

 
# "path/to/where/you/are"
PS1="$PS1\e[32;01m\w\e[0m \n"
 

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'

git config --global color.ui auto

alias add='git add -A :/; git status'

function commit() {
    git commit -m "$*"
}
alias commit=commit

alias red='redshift -l 41.1:-73.4 -v -t'

alias mongo='mongod --dbpath ~/mongodb-linux-x86_64-2.4.9/data/'


function euler() {
  if [ $1 == "rb" ]
    then
    ruby ~/euler/p$2/p$2.rb
  elif [ $1 == "js" ]
    then
    nodejs ~/euler/p$2/p$2.js
  fi
}

alias e=euler

alias v='vim -c "source ~/.vimrc"'

alias show='ls -Ahog  --group-directories-first'
alias sho='ls -A --group-directories-first'

alias ..='cd ..'

([ -d .git ] && echo $(git rev-parse --abbrev-ref HEAD))