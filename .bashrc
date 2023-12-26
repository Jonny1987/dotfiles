############################ MISC ###########################
###################################################################

#source ~/.bash_profile

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.vimpkg/bin

export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:`pwd`/dev/flutter/bin"
export PATH="$PATH:`pwd`/android-studio/bin"

# to get gcloud on cli
export PATH="$HOME/google-cloud-sdk/bin:$PATH"

# There are some plugs in /usr/bin/.local
export PATH="$PATH:$HOME/.local/bin"

# Python won’t try to write .pyc or .pyo files on the import of source modules.
export PYTHONDONTWRITEBYTECODE=True

export VISUAL=vim
export EDITOR="$VISUAL"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

export VISUAL=vim
export EDITOR="$VISUAL"

# Avoid accidental exitting
exit() {
    read -t5 -n1 -p "Do you really wish to exit? [yN] " should_exit || should_exit=y
    case $should_exit in
        [Yy] ) builtin exit $1 ;;
        * ) printf "\n" ;;
    esac
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# POSTGRES ALIASES
#alias pg_dump=
#alias psql=
#alias dropdb=
#alias createdb=

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
  #if [ -f /usr/share/bash-completion/bash_completion ]; then
    #. /usr/share/bash-completion/bash_completion
  #elif [ -f /etc/bash_completion ]; then
    #. /etc/bash_completion
  #fi
#fi

getvenv() {
   echo $VIRTUAL_ENV 
   dirname $VIRTUAL_ENV
}


function cd() {
  builtin cd "$@"

  ## If env folder is found then activate the vitualenv
  if [[ -d ./venv ]] ; then
    source ./venv/bin/activate
    eval "$(pyenv init -)"
  elif [[ -d ./env ]] ; then
    source ./env/bin/activate
    eval "$(pyenv init -)"
  elif [[ -n "$VIRTUAL_ENV" ]] ; then
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}


############################ GAMBLING ###########################
###################################################################
alias autoclick="~/autoclicker/autoclicker.sh"

############################ NETWORK ###########################
###################################################################

ifport() {
    udevadm info -p /sys/class/net/$1 | head -n 1 | cut -d"/" -f 7
}

nsport() {
    sudo ip netns exec $1 udevadm info -p /sys/class/net/eth1 | head -n 1 | cut -d"/" -f 7
}
    
rebind() {
    echo $1 | sudo tee /sys/bus/usb/drivers/usb/unbind && echo $1 | sudo tee /sys/bus/usb/drivers/usb/bind
}

ifrebind() {
    rebind $(ifport $1)
}

nsrebind() {
    port=$(sudo ip netns exec $1 udevadm info -p /sys/class/net/eth1 | head -n 1 | cut -d'/' -f 7)
    echo $port | sudo tee /sys/bus/usb/drivers/usb/unbind && echo $port | sudo tee /sys/bus/usb/drivers/usb/bind
}

lastrebind() {
    last_ns=$(sudo docker ps -l --format='{{.Names}}' | cut -d'-' -f 2)
    nsrebind $last_ns
}

lastport() {
    last_ns=$(sudo docker ps -l --format='{{.Names}}' | cut -d'-' -f 2)
    nsport $last_ns
}

loadwp() {
    webpage=$1
    containers=sudo docker ps --format='{{.Names}}'
    for container in $containers
    do
        sudo docker exec $container google-chrome $webpage
    done
}

nextwp() {
    webpage=$1
    declare -p webpage | sudo tee /usr/local/bin/webpage > /dev/null
}

rulesoff() {
    rules_file=/etc/udev/rules.d/1-physical-netns.rules
    first_char=$(head -c 1 $rules_file)
    if [ $first_char != "#" ]
    then
        sudo sed -i '1s/^/#/' /etc/udev/rules.d/1-physical-netns.rules
    fi
}

ruleson() {
    rules_file=/etc/udev/rules.d/1-physical-netns.rules
    first_char=$(head -c 1 $rules_file)
    if [ $first_char == "#" ]
    then
        sudo sed -i '1s/^.//' $rules_file
    fi
}

stick() {
    sudo sed -i '1s/^/#/' /etc/udev/rules.d/1-physical-netns.rules && if [ $# -eq 1 ]; then ns=$1; else ns=$(sudo docker ps -l --format="{{.Names}}" | cut -d"-" -f 2); fi; sudo ip netns exec $ns ip link set eth1 netns 1
}

rstick() {
    sudo sed -i '1s/^.//' /etc/udev/rules.d/1-physical-netns.rules && if [ $# -eq 1 ]; then ns=$1; else ns=$(sudo docker ps -l --format="{{.Names}}" | cut -d"-" -f 2); fi; sudo ip link set eth1 netns $ns && sudo ip netns exec $ns dhclient eth1
}

############################ BBOXX ###########################
###################################################################

# This is used in the python client .env file. If unset causes problems then find another way
unset USERNAME

export PATH="$PATH:/space/git/arcanist/bin/"
export PATH="$PATH:/space/git/devtools/bin/"

############################ COLORS ###########################
###################################################################


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
    #if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    ## We have color support; assume it's compliant with Ecma-48
    ## (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    ## a case would tend to support setf rather than setaf.)
    #color_prompt=yes
    #else
    #color_prompt=
    #fi
#fi


#if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\$ '
#else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\$ '
#fi

#unset color_prompt force_color_prompt


############################ HISTORY ###########################
###################################################################

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=100000
export HISTFILESIZE=200000
HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth:erasedups  

# When the shell exits, append to the history file instead of overwriting it
#shopt -s histappend
#PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# After each command, append to the history file and reread it
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -r;"


############################ PLUGINS ###########################
###################################################################

#source ~/.git-prompt.sh

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# VirtualEnvWrapper
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel
#source /usr/local/bin/virtualenvwrapper.sh


############################ COMMIT NAVIGATION ###########################
###################################################################

alias sfg="git sfg"

alias pu="git pu"

alias mka="git mka"

alias gpul="git gpul"

alias supstash="git supstash"

alias curbr="git curbr"

alias cbr="git cbr"

alias unpus="git unpus"

alias unpul="git unpul"

alias gadd="git gadd" 

alias subd="git subd"
 
alias nomrgci="git nomrgci"

alias gdif="git gdif"

alias pb="git pb"

alias gblame="git gblame"

alias gstash="git gstash"

alias spu="git spu"

alias gpul="git gpul"

##################### DOCKER ALIASES #####################
##########################################################

alias dockstop='docker stop $(docker ps -a -q)'
alias dockrm='docker rm $(docker ps -a -q)'
alias dockrmi='docker rmi $(docker images -a -q)'


##################### USEFUL ALIASES #####################
##########################################################

alias meld="/Applications/Meld.app/Contents/MacOS/Meld"

killport() {
	lsof -i:$1 | tail -n +2 | awk '{print $2}' | paste -s | xargs kill -9
}

killname() {
	ps aux | grep chrome | cut -d " " -f 3 | xargs kill
}

alias brc="$EDITOR ~/.bashrc"

alias vrc="$EDITOR ~/.vimrc"

alias gcfg="$EDITOR ~/.gitconfig"

editbash() {
	term="^$1()"
	line=$(awk "/$term/{ print NR; exit }" ~/.bashrc)
	if [ -z "$line" ]; then
		term="^alias $1"
		line=$(awk "/$term/{ print NR; exit }" ~/.bashrc)
		if [ -z "$line" ]; then
			echo "No function found in bashrc"
			return
		fi
	fi
	sublime-text-3 ~/.bashrc:$line:0
}

alias coft="git coft"

alias click="xdg-open"

alias subl="sublime-text-3"

cmdff() {
	if [ $# -eq 1 ]; then
		echo "No filename given"
		return
	elif [ $# -ge 3 ]; then
		if [ "$2" != "-i" ]; then
			echo "Must only give one filename"
			return
		else
			comd="-iname"
			n=$3
		fi
	else
		n=$2
		comd="-name"
	fi
	results=$(find $comd $n)
	number=$(echo "$results" | wc -l)
	if [ $number -eq 1 ] && [ -z $results ]; then
		echo "Did not return any results"
	elif [ $number -eq 1 ]; then
		$1 $results
	else
		PS2="please select"
		select d in $results; do
			if [ -n "$d" ]; then
				$1 $d
				break
		    fi
		done
	fi 
}

# Needed when install homebrew vim and want this to override native mac vim
alias sff="cmdff sublime-text-3"

alias gff="cmdff 'git blame'"

alias ff="find -name"

brci() {
	if [ $# -eq 1 ]
		then
			from=$1
		else
			from="master"
	fi
	sfg "--no-pager log $from.."
}

showbrci() {
	if [ $# -eq 1 ]
	    	then
    			from=$1
    		else
    			from="B_FrontEnd_DevBase"
    	fi
	sfg "--no-pager show $from.."
}

allci() {
	sfg "--no-pager log -s $1"
}

sbr() {
    git br | grep $1
}

export PATH=/Library/PostgreSQL/9.6/bin/:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
ctags=/usr/local/bin/ctags
