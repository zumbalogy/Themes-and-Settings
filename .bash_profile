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







[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile




 
 
# prompt colors
# "username@hostname:"
PS1="\e[34;01m\u\e[0m@\e[31;01m\h\e[0m:"
 
# "path/to/where/you/are"
PS1="$PS1\e[32;01m\w\e[0m"
 
# "(gitbranch)"
PS1="$PS1 \$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \")\[\033[1;33m\]\[\033[1;37m\]\n\$ \[$(tput sgr0)\]"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

git config --global color.ui auto



function wdi_nyc_proc_nav() {
    cd ~/ga/WDI_NYC_Proc/w0$1/d0$2/Sanjay_Harvey
}
alias ga=wdi_nyc_proc_nav


alias add='git add -A; git status'
alias commit='git commit -m'