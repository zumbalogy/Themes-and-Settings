# Gaurd against non-interactive shells
[[ $- == *i* ]] || return

#########################################################

# https://github.com/Mayccoll/Gogh
# bash -c  "$(wget -qO- https://git.io/vQgMr)"
# ocean next
# background #21272B

function color() { echo "$(tput setaf $1)${@:2}$(tput sgr0)"; }
function bold() { echo "$(tput bold)$*$(tput sgr0)"; }

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

HISTCONTROL=ignoredups:erasedups
HISTFILESIZE=9000
HISTSIZE=9000
HISTIGNORE='sho:add'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

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

function branch() {
  if [ -z "$1" ]; then
    git branch
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

alias ..='cd ..'
alias ~='cd ~'
alias -- -='cd -'

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

alias batgrep='~/bat-extras/src/batgrep.sh'

function gg() {
  if [ -t 0 ]; then
    batgrep --smart-case --color $* | bat --style="grid"
    return
  fi
  rg --pretty --context 2 $*
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
# https://github.com/BurntSushi/ripgrep
export PATH="$HOME/.cargo/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

[[ -s "$HOME/.kiex/scripts/kiex" ]] && source "$HOME/.kiex/scripts/kiex"

#########################################################

date
git_branch
