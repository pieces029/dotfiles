# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#PS1
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

export PS1="[\e[0;32m\u@\h: \e[m\e[0;36m\w\e[m\e[1;35m\$(parse_git_branch)\e[m] >\n$ "

# User specific aliases and functions

#Exports
## export JAVA_HOME JDK/JRE ##
export JAVA_HOME="/usr/bin/java"
export ANDROID_HOME="$HOME/Android/Sdk"

#Path
PATH=$HOME/bin:$PATH
PATH=$ANDROID_HOME/tools:$PATH
PATH=$ANDROID_HOME/platform-tools:$PATH
PATH=/usr/local/heroku/bin:$PATH

#Aliases
alias c='clear'
alias copy='xclip -sel clip' #copy whatever is piped in into the clipboard
alias top='htop'
alias la='ls -la'
alias ee='emacs -nw'
alias shit='echo "aww, it will be alright"'
alias vpnhome='sshuttle --dns 192.168.0.1 -r pi@juta.chickenkiller.com:22 0/0'
alias vpnwork='sshuttle --dns 204.62.151.87 -r areitz@gate.sierrabravo.net 0/0'
alias df='df -H'
alias du='du -ch'
alias open='dolphin . &> /dev/null &'
alias ports='netstat -tulanp'
alias myip='wget http://ipecho.net/plain -O - -q && echo ""'
alias untar='tar -zxvf'
alias e='exit'
alias q='exit'
alias internet='ping google.com'

#Functions

# setup git dev for work
function workrepo() {
	git config user.email "andrew.reitz@nerdery.com"
  git config user.name "Andrew Reitz"
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

# Find something in a directory above the one you are in
function upfind() {
  dir=`pwd`
  while [ "$dir" != "/" ]; do
    path=`find "$dir" -maxdepth 1 -name $1`
    if [ ! -z $path ]; then
      echo "$path"
      return
    fi
    dir=`dirname "$dir"`
  done
}

# Finds the gradle wrapper and executes it with the parameter passed in
function gw() {
    $(upfind gradlew) $@
}

# Finds the nearest build.gradle and executes it with the parameter passed in
function g() {
    gradle -b $(upfind build.gradle) $@
}

# Run these commands when terminal opens
# Prints a firefly quote in red
red='\e[0;31m' # Color Red
NC='\e[0m' # No Color
echo -e "${red}"
fortune firefly
echo -e "${NC}"

# HomeShick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
# check update everytime shell terminal is opened
homeshick --quiet refresh
# homeshick completion
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/areitz/.sdkman"
[[ -s "/home/areitz/.sdkman/bin/sdkman-init.sh" ]] && source "/home/areitz/.sdkman/bin/sdkman-init.sh"
