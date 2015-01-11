export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin
export PATH=$PATH:/Users/sh/chromedriver/
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_11.jdk/Contents/Home"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into shell session *as a function*

clear
Date
(git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")

shopt -s histappend
HISTFILESIZE=5000
HISTSIZE=1000
HISTCONTROL=ignoredups

git config --global color.ui auto

alias light="sudo ~/LightTable/deploy/LightTable"

# "path/to/where/you/are"
PS1="\e[32;01m\w\e[0m \n"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'

bind -x '"\C-l": date; clear'

alias ..='cd ..'
alias show='gls --color -A --group-directories-first -l'
alias sho='gls --color -A --group-directories-first'

alias add='git add -A :/; git status'

function commit() {
  git commit -m "$*"
}
alias commit=commit

function cd_git(){
  cd $1 + '/'
  (git rev-parse --is-inside-work-tree &> /dev/null  && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")
}

function git_stat(){
  (git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git status)\033[0m")
  pwd
}

alias cd=cd_git
alias pwd=git_stat

alias diff='git diff HEAD'
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'

function note(){
  cd ~/notes >> /dev/null
  rm lock.zip
  git add --all
  git commit -m 'delete zip'  >> /dev/null
  echo -e "\n\033[0;35m$(date)\033[0m\n$*\n" >> notes.txt
  zip lock.zip notes.txt --password "{{secret}}" >> /dev/null
  git add .
  git commit -m 'add zip'  >> /dev/null
  git push origin master  -q
  cd -  >> /dev/null
}

alias note=note
alias notes="tail -30 ~/notes/notes.txt"

