# source ~/.profile

autoload -U colors && colors
git config --global color.ui always
git config --global color.status always

date
(git rev-parse --is-inside-work-tree &> /dev/null && echo -e "\033[0;35m$(git rev-parse --abbrev-ref HEAD)\033[0m")

PROMPT="%{$fg_bold[green]%}%~%{$reset_color%}"$'\n'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

DIRSTACKSIZE=10
DIRSTACKFILE=~/.zdirs
setopt AUTO_PUSHD # TODO: autocomplete on cd-, and also have it not print

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

function _copy() {
  echo $BUFFER | xclip -i -sel c
}

function _toggle_sudo() {
  local SAVE=$BUFFER
  zle kill-whole-line
  if [[ $SAVE =~ "sudo" ]]; then
    local CLEAN=$(echo "$SAVE" | sed 's/^sudo //g')
    zle -U "$CLEAN"
  else
    zle -U "sudo $SAVE"
  fi
}

function _cd_jump() {
  pushd $OLDPWD > /dev/null
  zle reset-prompt;
}

# TODO: make it just scroll, not print a whole frame.
function _my_clear() {
  date;
  zle clear-screen
}

zle -N _my_clear
zle -N _copy
zle -N _toggle_sudo
zle -N _cd_jump

bindkey ';6C' _copy
bindkey ';6D' _copy
bindkey '^[[3;5~' backward-kill-word
bindkey '^@' _toggle_sudo
bindkey '^_' _cd_jump
bindkey '^l' _my_clear

alias light="sudo ~/LightTable/deploy/LightTable"

alias ..='cd ..'
alias nano='nano -E'
alias show='ls --color -Alh --group-directories-first'
alias sho='ls --color -A --group-directories-first'
alias shotime='sho --sort=time'
alias showtime='show --sort=time'
alias shosize='sho --sort=size'
alias showsize='show --sort=size'

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

alias branch='git_branch'
alias add='git add -A :/; git_stat'
alias stat='git diff HEAD --stat'
alias commit='git_commit'
alias dif='git diff HEAD | diff-highlight | ~/projects/diff-so-fancy/lib/diff-so-fancy.pl | less -RFX'
alias diff='git diff HEAD | diff-highlight | ~/projects/diff-so-fancy/lib/diff-so-fancy.pl | less -RFX'
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias pull='git pull'
alias pp='pull; push'

# TODO: want to chance branches after i make it. i guess checkout -b works
# alias branch="git branch --track $1; git checkout $1"
# alias branches='git branch -a'

# function note() {
#   # TODO
# }
#
# alias note=note
# alias notes="tail -30 ~/notes/notes.txt"

function run_fortran() {
  gfortran -o $1.fortran_exe $1.f90
  $1.fortran_exe
  rm $1.fortran_exe
}

function euler() {
  dir=$1
  file=$1
  if [[ $1 =~ ^.$ ]]; then
    dir=0$1
  fi
  if [[ $1 =~ ^0.$ ]]; then
    file=${1:1}
  fi
  file=p$file
  location=~/euler/$dir/$file
  case "$2" in
    rb      ) ruby $location.rb;;
    ruby    ) ruby $location.rb;;
    jl      ) julia $location.jl;;
    julia   ) julia $location.jl;;
    js      ) node $location.js;;
    node    ) node $location.js;;
    coffee  ) coffee $location.coffee;;
    clj     ) lein exec $location.clj;;
    clojure ) lein exec $location.clj;;
    racket  ) racket $location.rkt;;
    rkt     ) racket $location.rkt;;
    fortran ) run_fortran $location;;
    f90     ) run_fortran $location;;
    fort    ) run_fortran $location;;
    java    )
      javac $location.java
      java -classpath ~/euler/$dir $file
      rm $location.class
    ;;
    *) echo "nothing found for $2";;
  esac
}

alias e=euler

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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

alias -s rb=ruby
alias -s js=node
alias -s jl=julia
alias -s coffee=coffee
alias -s clj='lein exec'

export RABBITMQ_ADDRESS=tcp://10.129.242.20:1883

# load virtualenvwrapper for python (after custom PATHs)
venvwrap='virtualenvwrapper.sh'
/usr/bin/which -a $venvwrap &> /dev/null
if [ $? -eq 0 ]; then
  venvwrap=`/usr/bin/which $venvwrap`
  source $venvwrap
fi

# TODO: get jazor back, it can sort without having to compile the latest jq
# TODO: if cant parse, just cat it
alias json="jq -C '.'"
alias clip='xclip -selection c'
alias paste='xclip -selection clipboard -o'
alias cat='pygmentize -g'

alias install='sudo apt-get install'
alias update='sudo apt-get update'
alias resu='sudo $SHELL -ic "$(fc -ln -1)"'

function trigger() {
  if [ "$#" -eq 1 ]; then
    first="."
  else
    first=$1
    shift
  fi
  while inotifywait -rqe close_write $first;
    do $SHELL -ic $*;
  done
}

alias trigger='trigger'

function asrun() {
  RAND=$(openssl rand -hex 40)
  OBJPATH=$(echo /tmp/$(echo $RAND).o)
  EXEPATH=$(echo /tmp/$(echo $RAND))
  as $1 -o $OBJPATH &&
  ld $OBJPATH -o $EXEPATH &&
  $EXEPATH
  echo $?
  rm $EXEPATH &>/dev/null
}

alias asrun='asrun'

mkdir -p ~/bin
PATH=$PATH:~/bin
export PATH

mkdir -p /bin
PATH=$PATH:/bin
export PATH

PATH=$PATH:/usr/lib/postgresql/9.1/bin
export PATH

PATH=$PATH:/home/ash/.local/bin
export PATH
