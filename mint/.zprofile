# source ~/.profile
source ~/.rvm/scripts/rvm
source ~/.nvm/nvm.sh

autoload -U colors && colors

git config --global color.ui auto

nvm use iojs > /dev/null

date
(git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

bindkey '\e[A' history-beginning-search-backward
bindkey '\eOA' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '\eOB' history-beginning-search-forward

bindkey ';3C' end-of-line
bindkey ';5C' forward-word
bindkey ';3D' beginning-of-line
bindkey ';5D' backward-word

bindkey ';5A' history-search-backward
bindkey ';3A' history-search-backward
bindkey ';3B' history-search-forward
bindkey ';5B' history-search-forward

alias light="sudo ~/LightTable/deploy/LightTable"

# "path/to/where/you/are"
# PS1=$'\033[0;32m%~\033[0m'$'\n' # maybe make bold
PROMPT="%{$fg_bold[green]%}%~%{$reset_color%}"$'\n'

# bind -x '"\C-l": date; clear' # todo: this. also make it just scroll me, not blow away a whole frame like something stupid.

alias ..='cd ..'
alias show='ls --color -A --group-directories-first -l'
alias sho='ls --color -A --group-directories-first'

alias add='git add -A :/; git status'

function commit() {
  git commit -m "$*"
}
alias commit=commit

function cd_git() {
  cd $1
  (git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")
}

function git_stat() {
  (git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git status)\033[0m")
  pwd
}

alias cd=cd_git
alias pwd=git_stat

alias diff='git diff HEAD'
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias pull='git pull'
alias pp='pull; push'

function note() {
  cd ~/notes > /dev/null
  rm lock.zip
  git add --all
  git commit -m 'delete zip'  >> /dev/null
  echo -e "\n\033[0;35m$(date)\033[0m\n$*\n" >> notes.txt
  zip lock.zip notes.txt --password "{{secret}}" > /dev/null
  git add .
  git commit -m 'add zip'  > /dev/null
  git push origin master -q
  cd - > /dev/null
}

alias note=note
alias notes="tail -30 ~/notes/notes.txt"

alias r=rspec
alias rake='bundle exec rake'

function euler() {
  dir=$1
  file=$1
  if [[ $1 =~ ^.$ ]]
    then
    dir=0$1
  fi
  if [[ $1 =~ ^0.$ ]]
    then
    file=${1:1}
  fi
  if [ $2 == "rb" ]
    then
    ruby ~/euler/$dir/p$file.rb
  elif [ $2 == "ruby" ]
    then
    ruby ~/euler/$dir/p$file.rb
  elif [ $2 == "js" ]
    then
    node ~/euler/$dir/p$file.js
  elif [ $2 == "node" ]
    then
    node ~/euler/$dir/p$file.js
  elif [ $2 == "coffee" ]
    then
    coffee ~/euler/$dir/p$file.coffee
  elif [ $2 == "clj" ]
    then
    lein exec ~/euler/$dir/p$file.clj
  elif [ $2 == "clojure" ]
    then
    lein exec ~/euler/$dir/p$file.clj
  elif [ $2 == "java" ]
    then
    javac ~/euler/$dir/p$file.java
    java -classpath ~/euler/$dir p$file
    rm ~/euler/$dir/p$file.class
  fi
}

alias e=euler

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# function log_git() {
#   if [[ $1 ]]
#     then
#     count=$1
#   else
#     count=4
#   fi
#   git log -${count} --pretty=format:"%C(blue)%h %ar%C(reset) %an: %s%n" --stat | ruby -e '
#     while a = gets
#       next if a.match(/\d+ fil(e|es) changed, \d+ insertio(n|ns)\(\+\), \d+ deletion/)
#       if (m = a.match(/.*\//)) && a.match(/(\+|\-)/)
#         len = m.to_s.length
#         a.sub!(" +", (" " * len) + "+")
#         a.sub!(" -", (" " * len) + "-")
#         a.sub!(m.to_s, "")
#       end
#       a.sub!("+", "\033[32m+")
#       a.sub!("-", "\033[31m-")
#       a += "\033[0m"
#       a.gsub!(/ \|\s+\d+ /, " ")
#       print a
#     end
#   '
# }
# could maybe use grep -v, instead, to remove results.

function log() {
  if [ $1 == "git" ]
    then
    log_git $2
  fi
}

alias log='log'

alias -s '_spec.rb'=bundle exec rspec
