# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   	return
fi

PS1='\h:\W \u\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
		local SEARCH=' '
		local REPLACE='%20'
		local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
		printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi

function get_xserver ()
{
	case $TERM in
	    xterm )
	    	XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
	    	# Ane-Pieter Wieringa suggests the following alternative:
	    	#  I_AM=$(who am i)
	    	#  SERVER=${I_AM#*(}
	    	#  SERVER=${SERVER%*)}
	    	XSERVER=${XSERVER%%:*}
	    	;;
	    aterm | rxvt)
	    	# Find some code that works here. ...
	    	;;
	esac
}

if [ -z ${DISPLAY:=""} ]; then
	get_xserver
	if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) ||
	    ${XSERVER} == "unix" ]]; then
			DISPLAY=":0.0"          # Display on local host.
	else
		DISPLAY=${XSERVER}:0.0     # Display on remote host.
	fi
fi

export DISPLAY

alias debug="set -o nounset; set-o xtrace"
alias mv="mv -iv"
alias cp="cp -iv"
alias jchuck="~/.chuckrc; chuck"

ulimit -S -c 0

set -o notify
set -o noclobber
set -o ignoreeof
set -o vi
alias ll="ls -a1 -G"
shopt -s cdspell
shopt -s cdable_vars
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob
echo -e "${BCyan}This is BASH ${BRed}${BASH_VERSION%.*}${BCyan}\
	- DISPLAY on ${BRed}$DISPLAY${NC}\n"
date

#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.


# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset


ALERT=${BWhite}${On_Red} # Bold White on red background

#-------------------------------------------------------------
# Shell Prompt - for many examples, see:
#       http://www.debian-administration.org/articles/205
#       http://www.askapache.com/linux/bash-power-prompt.html
#       http://tldp.org/HOWTO/Bash-Prompt-HOWTO
#       https://github.com/nojhan/liquidprompt
#-------------------------------------------------------------
# Current Format: [TIME USER@HOST PWD] >
# TIME:
#    Green     == machine load is low
#    Orange    == machine load is medium
#    Red       == machine load is high
#    ALERT     == machine load is very high
# USER:
#    Cyan      == normal user
#    Orange    == SU to user
#    Red       == root
# HOST:
#    Cyan      == local session
#    Green     == secured remote connection (via ssh)
#    Red       == unsecured remote connection
# PWD:
#    Green     == more than 10% free disk space
#    Orange    == less than 10% free disk space
#    ALERT     == less than 5% free disk space
#    Red       == current user does not have write privileges
#    Cyan      == current filesystem is size zero (like /proc)
# >:
#    White     == no background or suspended jobs in this shell
#    Cyan      == at least one background job in this shell
#    Orange    == at least one suspended job in this shell
#
#    Command is added to the history file each time you hit enter,
#    so it's available to all shells (using 'history -a').


# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
	CNX=${Green}        # Connected on remote machine, via ssh (good).
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
	CNX=${ALERT}        # Connected on remote machine, not via ssh (bad).
else
	CNX=${BCyan}        # Connected on local machine.
fi

# Test user type:
if [[ ${USER} == "root" ]]; then
	SU=${Red}           # User is root.
elif [[ ${USER} != $(logname) ]]; then
	SU=${BRed}          # User is not login user.
else
	SU=${BCyan}         # User is normal (well ... most of us are).
fi

export PATH=/Applications/git-annex.app/Contents/MacOS:$PATH
export PATH=/usr/local/bin:$PATH:/usr/games/bin
export JAVA_HOME=$(/usr/libexec/java_home)

export PYTHONPATH=~/workspace/science/libraries/python
stty stop undef
if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi
alias edit_karabiner="vim /Users/nessmorris/Library/Application\ Support/Karabiner/private.xml"
alias clojure="java -cp ~/playspace/clojure/clojure-1.6.0/clojure-1.6.0.jar clojure.main"
