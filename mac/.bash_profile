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
  cd $1
  (git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")
}

function git_stat(){
  (git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git status)\033[0m")clearclear
Date
(git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")


export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
git config --global color.ui auto

# "path/to/where/you/are"
PS1="\e[32;01m\w\e[0m \n"

alias ..='cd ..'
alias show='gls --color -A --group-directories-first -l'
alias sho='gls --color -A --group-directories-first'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'

bind -x '"\C-l": date; clear'

alias nano='nano -E'

function git_commit() {
  git commit -m "$*"
}

function git_cd() {
  cd $1
  (git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")
}

function git_stat() {
  (git rev-parse --is-inside-work-tree &> /dev/null && echo -e "$(git status -sb)")
}

function git_branch() {
  if [[ $(git branch -a) =~ $1 ]]; then
    git checkout $1
  else
    git checkout -b $1
    git push origin $(git rev-parse --abbrev-ref HEAD)
    git branch --set-upstream-to=origin/$1 $1
  fi
}

alias cd='git_cd'
alias pwd='git_stat; pwd'

git config --global core.pager "diff-so-fancy | less -RFX"

alias branch='git_branch'
alias add='git add -A :/; git_stat'
alias stat='git diff HEAD --stat'
alias commit='git_commit'
alias dif='git diff HEAD'
alias diff='git diff HEAD'
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias pull='git pull'
alias pp='pull; push'

function log_git() {
  if [ $1 ]
    then
    count=$1
  else
    count=4
  fi
  git log -${count} --pretty=format:"%C(blue)%h %ar%C(reset) %an: %s%n" --stat | ruby -e '
    while a = gets
      next if a.match(/\d+ fil(e|es) changed, \d+ insertio(n|ns)\(\+\), \d+ deletion/)
      if (m = a.match(/.*\//)) && a.match(/(\+|\-)/)
        len = m.to_s.length
        a.sub!(" +", (" " * len) + "+")
        a.sub!(" -", (" " * len) + "-")
        a.sub!(m.to_s, "")
      end
      a.sub!("+", "\033[32m+")
      a.sub!("-", "\033[31m-")
      a += "\033[0m"
      a.gsub!(/ \|\s+\d+ /, " ")
      print a
    end
  '
}
# could maybe use grep -v, instead, to remove results.

function log() {
  if [ $1 == "git" ]
    then
    log_git $2
  fi
}

alias log='log'


alias resu='sudo $SHELL -ic "$(fc -ln -1)"'

alias cat='pygmentize -g'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export OCI_LIB_DIR=/opt/oracle/Software/instantclient
export OCI_INC_DIR=/opt/oracle/Software/instantclient/sdk/include


# this is in ~/.inputrc
# https://superuser.com/questions/90196/case-insensitive-tab-completion-in-bash
# set completion-ignore-case on
# set show-all-if-ambiguous on
# TAB: menu-complete
Date
(git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")


export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
git config --global color.ui auto

# "path/to/where/you/are"
PS1="\e[32;01m\w\e[0m \n"

alias ..='cd ..'
alias show='gls --color -A --group-directories-first -l'
alias sho='gls --color -A --group-directories-first'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'

bind -x '"\C-l": date; clear'

alias nano='nano -E'

function git_commit() {
  git commit -m "$*"
}

function git_cd() {
  cd $1
  (git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")
}

function git_stat() {
  (git rev-parse --is-inside-work-tree &> /dev/null && echo -e "$(git status -sb)")
}

function git_branch() {
  if [[ $(git branch -a) =~ $1 ]]; then
    git checkout $1
  else
    git checkout -b $1
    git push origin $(git rev-parse --abbrev-ref HEAD)
    git branch --set-upstream-to=origin/$1 $1
  fi
}

alias cd='git_cd'
alias pwd='git_stat; pwd'

git config --global core.pager "diff-so-fancy | less -RFX"

alias branch='git_branch'
alias add='git add -A :/; git_stat'
alias stat='git diff HEAD --stat'
alias commit='git_commit'
alias dif='git diff HEAD'
alias diff='git diff HEAD'
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias pull='git pull'
alias pp='pull; push'

function log_git() {
  if [ $1 ]
    then
    count=$1
  else
    count=4
  fi
  git log -${count} --pretty=format:"%C(blue)%h %ar%C(reset) %an: %s%n" --stat | ruby -e '
    while a = gets
      next if a.match(/\d+ fil(e|es) changed, \d+ insertio(n|ns)\(\+\), \d+ deletion/)
      if (m = a.match(/.*\//)) && a.match(/(\+|\-)/)
        len = m.to_s.length
        a.sub!(" +", (" " * len) + "+")
        a.sub!(" -", (" " * len) + "-")
        a.sub!(m.to_s, "")
      end
      a.sub!("+", "\033[32m+")
      a.sub!("-", "\033[31m-")
      a += "\033[0m"
      a.gsub!(/ \|\s+\d+ /, " ")
      print a
    end
  '
}
# could maybe use grep -v, instead, to remove results.

function log() {
  if [ $1 == "git" ]
    then
    log_git $2
  fi
}

alias log='log'


alias resu='sudo $SHELL -ic "$(fc -ln -1)"'

alias cat='pygmentize -g'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export OCI_LIB_DIR=/opt/oracle/Software/instantclient
export OCI_INC_DIR=/opt/oracle/Software/instantclient/sdk/include
  pwd
}

alias cd=cd_git
alias pwd=git_stat

alias diff='git diff HEAD'
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

function note(){
  cd ~/notes >> /dev/null
  rm lock.zip
  git add --all
  git commit -m 'delete zip'  >> /dev/null
  echo -e "\n\033[0;35m$(date)\033[0m\n$*\n" >> notes.txt
  zip lock.zip notes.txt --password "{{secret}}" >> /dev/null
  git add .
  git commit -m 'add zip'  >> /dev/null
  git push origin master -q
  cd -  >> /dev/null
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
