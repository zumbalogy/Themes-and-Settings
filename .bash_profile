# Gaurd against non-interactive shells
[[ $- == *i* ]] || return

#########################################################

function isInt() {
  [ "$1" -eq "$1" ] 2>/dev/null
}

#########################################################

# https://github.com/Mayccoll/Gogh
# bash -c  "$(wget -qO- https://git.io/vQgMr)"
# ocean next
# background #21272B

function bold() { echo "$(tput bold)$*$(tput sgr0)"; }
function color() { echo "$(tput setaf $1)${@:2}$(tput sgr0)"; }

alias red="color 1"
alias green="color 2"
alias yellow="color 3"
alias blue="color 4"
alias pink="color 5"

#########################################################

# Prompt: \w is current dir
PS1="$(bold $(blue \\w)) \n"
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

#########################################################

shopt -s histappend
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

HISTIGNORE='sho:add'
HISTSIZE=9000
HISTFILESIZE=9000
HISTCONTROL=ignoredups:erasedups

#########################################################

function has_git() {
  git rev-parse --is-inside-work-tree &> /dev/null
}

function git_branch() {
  has_git && pink $(git rev-parse --abbrev-ref HEAD)
}

function cd_git() {
  cd $1
  git_branch
}

function commit() {
  git commit -m "$*"
}

function git_select() {
  branches=($(git branch | tr '*' ' '))

  while true; do
    current_branch=$(git symbolic-ref --short HEAD)
    i=1
    for b in "${branches[@]}"; do
      if [ "$b" = "$current_branch" ]; then
        color 2 "$i) $b"
      else
        echo "$i) $b"
      fi
      let i++
    done

    read -p "> " reply

    [ -z "$reply" ] && break

    if ((isInt $reply) && [ "$i" -gt "$reply" ]); then
      git checkout "${branches[reply - 1]}"
      break
    fi

    branches=($(printf -- '%s\n' "${branches[@]}" | rg "$reply"))
    len=${#branches[@]}

    if [ "$len" -eq "1" ]; then
      git checkout "${branches[0]}"
      break
    fi

    if [ "$len" -eq "0" ]; then
      echo "Not Found"
      break
    fi

    echo ''
  done
}

function branch() {
  if [ -z "$1" ]; then
    git_select
    return
  fi

  if [ "$*" = '-' ]; then
    git checkout -
    return
  fi

  git show-ref --verify --quiet refs/heads/"$1"

  if [ $? = 0 ]; then
    git checkout $*
    return
  fi

  read -p "New Branch $* [Y/n] " reply
  reply=${reply,,} # downcase

  if [[ $reply =~ ^(yes|y| ) ]] || [[ -z $reply ]]; then
    git checkout -b $*
  else
    echo "Cancelled"
  fi
}

function status() {
  git_branch
  git diff HEAD --shortstat | sed 's/ changed//; s/([-+])//g'
  echo ''
  git diff HEAD --compact-summary --color | \
  sed \$d | \
  sed -r "s/(.*)\(new\)/$(green 'A') \1     /" | \
  sed -r "s/(.*)\(new ..\)/$(green 'A') \1        /" | \
  sed -r "s/(.*)\(gone\)/$(red 'D') \1      /" | \
  sed -r "s/^ (.*)/$(yellow 'M')  \1/" | \
  sed "s/------------------/-----------------/" | \
  sed "s/++++++++++++++++++/+++++++++++++++++/"
}

# https://github.com/so-fancy/diff-so-fancy
git config --global core.pager "diff-so-fancy | less -RFX"
git config --global color.ui auto

alias add='git add -A :/; status'

alias cd=cd_git

alias dif='git diff HEAD'
alias diff='git diff HEAD'

alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias pull='git pull'
alias pp='pull; push'

#########################################################

function row {
  sed "$1q;d" ${@:2}
}

function col {
  local awk_cmd="awk '{print \$$1}'"
  eval $awk_cmd ${@:2}
}

#########################################################

alias ~='cd ~'
alias ..='cd ..'
alias -- -='cd -'

alias ffirst="row 1 | col 1"

alias resu='sudo $(history -p !!)'

# https://github.com/ogham/exa
# alias sho='ls --color -A --group-directories-first'
alias sho='exa -a --group-directories-first'
alias show='sho -l'

#########################################################

# https://github.com/sharkdp/bat
alias cat='bat'

alias log='git log | bat --style="grid"'

# https://github.com/eth-p/bat-extras
alias batman='~/bat-extras/src/batman.sh'
alias man='batman'

# https://github.com/BurntSushi/ripgrep
alias batgrep='~/bat-extras/src/batgrep.sh'

function gg() {
  if [ -t 0 ]; then
    batgrep --smart-case --color $* | bat --style="grid"
    return
  fi
  rg --smart-case --pretty --context 2 $*
}

#########################################################

# https://github.com/yaa110/cb
function copy() {
  if (( $# == 0 )); then
    cb
    return
  fi
  cb -t "$*"
}

alias paste='cb -p'

#########################################################

# https://github.com/sharkdp/fd
export PATH="$HOME/.cargo/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

[[ -s "$HOME/.kiex/scripts/kiex" ]] && source "$HOME/.kiex/scripts/kiex"

#########################################################

source ~/ronin/.bash_profile

#########################################################

date
git_branch
