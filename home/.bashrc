# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

#Exports
export ANDROID_HOME="$HOME/Apps/android-sdk"
export GROOVY_HOME="$HOME/Apps/groovy-2.2.2"

#Path
PATH=$HOME/bin:$PATH
PATH=$ANDROID_HOME/tools:$PATH
PATH=$ANDROID_HOME/platform-tools:$PATH
PATH=$GROOVY_HOME/bin:$PATH
PATH=/usr/local/heroku/bin:$PATH

#Aliases
alias c='clear'
alias copy='xclip -sel clip' #copy whatever is piped in into the clipboard
alias top='htop'
alias la='ls -la'
alias ee='emacs -nw'
alias shit='echo "aww, it will be alright"'
alias ss='static-server' #from bin
alias vpnhome='sshuttle --dns 192.168.0.1 -r areitz@icculus.andrewreitz.com:22 0/0'
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
# Adjust Brightness
function brightness() { sudo su -c "echo $1 > /sys/class/backlight/intel_backlight/brightness"; }

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

# Android DEX Debugging
function dex-method-count() {
  cat $1 | head -c 92 | tail -c 4 | hexdump -e '1/4 "%d\n"'
}
function dex-method-count-by-package() {
  dir=$(mktemp -d -t dex)
  baksmali $1 -o $dir
  for pkg in `find $dir/* -type d`; do
    smali $pkg -o $pkg/classes.dex
    count=$(dex-method-count $pkg/classes.dex)
    name=$(echo ${pkg:(${#dir} + 1)} | tr '/' '.')
    echo -e "$count\t$name"
  done
  rm -rf $dir
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
