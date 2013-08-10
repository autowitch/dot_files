
######################################################################################################################################################
################################# MY BASHRC FILE ################################### MY BASHRC FILE ################################### MY BASHRC FILE
######################################################################################################################################################


# .bashrc
# Creator:	Inameiname
# Version:	3.5
# Last modified: 9 July 2011
# Found through various sources (including several things by me)
# Commented out stuff is what I personally don't need,
# so use at your own risk
# Feel free to copy, share, tweak, eat, or whatever

# autowitch: Tweaked and tweaked and tweaked


######################################################################################################################################################
#----- ORIGINAL CONTENT ------ ORIGINAL CONTENT ------ ORIGINAL CONTENT ------ ORIGINAL CONTENT ------ ORIGINAL CONTENT ------ ORIGINAL CONTENT ------
######################################################################################################################################################


# Load settings specific to a machine
if [ -e "~/.bash_local" ]; then
    source ~/.bash_local
fi

# Load site specific settings
if [ -e "~/.bash_site" ]; then
    source ~/.bash_site
fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=99999
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #;;
#*)
    #;;
#esac

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases_git ]; then
    . ~/.bash_aliases_git
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


######################################################################################################################################################
#----- CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE ------ CUSTOM STARTS HERE
######################################################################################################################################################


######################################################################################################################################################
###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ######
######################################################################################################################################################


if [ "$PS1" ]; then	# if running interactively, then run till 'fi' at EOF:

# source ~/.bashlocalrc	# settings that vary per workstation
OS=$(uname)		# for resolving pesky os differing switches


######################################################################################################################################################
###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ###### BASH SETTINGS ######
######################################################################################################################################################

if [ -f ~/.bash-settings ]; then
    . ~/.bash-settings
fi

######################################################################################################################################################
###### BASH EXPORTS ###### BASH EXPORTS ###### BASH EXPORTS ###### BASH EXPORTS ###### BASH EXPORTS ###### BASH EXPORTS ###### BASH EXPORTS ######
######################################################################################################################################################

if [ -f ~/.bash-export ]; then
    . ~/.bash-export
fi

######################################################################################################################################################
###### COMMAND PROMPT & CLI ###### COMMAND PROMPT & CLI ###### COMMAND PROMPT & CLI ###### COMMAND PROMPT & CLI ###### COMMAND PROMPT & CLI ######
######################################################################################################################################################

if [ -f ~/.bash-prompt ]; then
    . ~/.bash-prompt

    # Force prompt wrapping on the smaller terminals
    num_cols=`tput cols`
    if (( $num_cols < 100 )); then
        export PL_NL_AFTER_PATH=true
    fi
    export PL_SHOW_RETURN_CODE=true
fi

if [ -d $HOME/Maildir/ ]; then
    export MAIL=$HOME/Maildir/
    export MAILPATH=$HOME/Maildir/
    export MAILDIR=$HOME/Maildir/
elif [ -f /var/mail/$USER ]; then
    export MAIL="/var/mail/$USER"
fi

if [ "$TERM" = "screen" ]; then
    export TERM=$TERMINAL
fi

# if [ "$OS" = "Linux" ]; then
#     source ~/.lscolorsrc
# elif [ "$OS" = "Darwin" ]; then
#     export LSCOLORS='gxfxcxdxbxegedabagacad'
# fi

function get_xserver()
{
    case $TERM in
       xterm )
            XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
            # Ane-Pieter Wieringa suggests the following alternative:
            # I_AM=$(who am i)
            # SERVER=${I_AM#*(}
            # SERVER=${SERVER%*)}
            XSERVER=${XSERVER%%:*}
            ;;
        aterm | rxvt)
        # Find some code that works here. ...
            ;;
    esac
}
if [ -z ${DISPLAY:=""} ]; then
    get_xserver
    if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) || \
      ${XSERVER} == "unix" ]]; then
        DISPLAY=":0.0"          # Display on local host.
    else
        DISPLAY=${XSERVER}:0.0  # Display on remote host.
    fi
fi
export DISPLAY

# if [ -f ~/.bash_exports ]; then . ~/.bash_exports ; fi
# if [ -f ~/.bash_functions ]; then . ~/.bash_functions ; fi
# if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases ; fi
# if [ -f ~/.bash_completion ]; then . ~/.bash_completion ; fi
# if [ -f /etc/bash_completion ]; then . /etc/bash_completion ; complete -cf sudo; fi



##################################################
# Alternative To The "200 Lines Kernel Patch That#
# Does Wonders" - not needed if have Linux kernel#
# 2.6.37 and higher				 #
##################################################

###### FOR DISTROS THAT USE '/cgroup/cpu' & '/etc/init.d/rc.local' (REDHAT/CENTOS?)
# Run sudo gedit /etc/init.d/rc.local & add following lines above "exit 0":
# 	mkdir -p /cgroup/cpu
# 	mount -t cgroup cgroup /cgroup/cpu -o cpu
# 	mkdir -m 0777 /cgroup/cpu/user
# 	echo "/usr/local/sbin/cgroup_clean" > /cgroup/cpu/release_agent
# Now, make it executable:
# sudo chmod +x /etc/init.d/rc.local
# To make sure that cgroups are deleted whenever the last task
# leaves, run sudo gedit /usr/local/sbin/cgroup_clean and copy-paste this:
# 	#!/bin/sh
# 	if [ "$*" != "/user" ]; then
# 	rmdir /cgroup/cpu/$*
# 	fi
# Now, make it executable:
# sudo chmod +x /usr/local/sbin/cgroup_clean
# Ensure the below ~/.bashrc section is uncommented
# Restart your computer to apply the changes.
#
#
#
# BEFORE YOU UNCOMMENT THE BELOW, MAKE SURE YOU'VE DONE THE ABOVE
#   if [ "$PS1" ] ; then
# 	mkdir -p -m 0700 /cgroup/cpu/user/$$ > /dev/null 2>&1
#       echo $$ > /cgroup/cpu/user/$$/tasks
#	echo "1" > /cgroup/cpu/user/$$/notify_on_release
#   fi



###### FOR DISTROS THAT USE '/sys/fs/cgroup/cpu' & '/etc/init.d/rc.local'
# Run sudo gedit /etc/init.d/rc.local & add following lines above "exit 0":
# 	mkdir -p /sys/fs/cgroup/cpu
# 	mount -t cgroup cgroup /sys/fs/cgroup/cpu -o cpu
# 	mkdir -m 0777 /sys/fs/cgroup/cpu/user
# 	echo "/usr/local/sbin/cgroup_clean" > /sys/fs/cgroup/cpu/release_agent
# Now, make it executable:
# sudo chmod +x /etc/init.d/rc.local
# To make sure that cgroups are deleted whenever the last task
# leaves, run sudo gedit /usr/local/sbin/cgroup_clean and copy-paste this:
# 	#!/bin/sh
# 	if [ "$*" != "/user" ]; then
# 	rmdir /sys/fs/cgroup/cpu/$*
# 	fi
# Now, make it executable:
# sudo chmod +x /usr/local/sbin/cgroup_clean
# Ensure the below ~/.bashrc section is uncommented
# Restart your computer to apply the changes.
#
#
#
# BEFORE YOU UNCOMMENT THE BELOW, MAKE SURE YOU'VE DONE THE ABOVE
#   if [ "$PS1" ] ; then
# 	mkdir -p -m 0700 /sys/fs/cgroup/cpu/user/$$ > /dev/null 2>&1
#       echo $$ > /sys/fs/cgroup/cpu/user/$$/tasks
#	echo "1" > /sys/fs/cgroup/cpu/user/$$/notify_on_release
#   fi



###### FOR UBUNTU (AND OTHER DISTROS THAT USE '/dev/cgroup/cpu' & '/etc/rc.local')
# Run sudo gedit /etc/rc.local & add following lines above "exit 0":
# 	mkdir -p /dev/cgroup/cpu
# 	mount -t cgroup cgroup /dev/cgroup/cpu -o cpu
# 	mkdir -m 0777 /dev/cgroup/cpu/user
# 	echo "/usr/local/sbin/cgroup_clean" > /dev/cgroup/cpu/release_agent
# Now, make it executable:
# sudo chmod +x /etc/rc.local
# To make sure that cgroups are deleted whenever the last task
# leaves, run sudo gedit /usr/local/sbin/cgroup_clean and copy-paste this:
# 	#!/bin/sh
# 	if [ "$*" != "/user" ]; then
# 	rmdir /dev/cgroup/cpu/$*
# 	fi
# Now, make it executable:
# sudo chmod +x /usr/local/sbin/cgroup_clean
# Ensure the below ~/.bashrc section is uncommented
# Restart your computer to apply the changes.
#
#
#
# BEFORE YOU UNCOMMENT THE BELOW, MAKE SURE YOU'VE DONE THE ABOVE
#    if [ "$PS1" ] ; then
# 	mkdir -p -m 0700 /dev/cgroup/cpu/user/$$ > /dev/null 2>&1
#   	echo $$ > /dev/cgroup/cpu/user/$$/tasks
#   	echo "1" > /dev/cgroup/cpu/user/$$/notify_on_release
#    fi



##################################################
# PATH						 #
##################################################

if [ "$UID" -eq 0 ]; then
    PATH=$PATH:/bin:/usr/local:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
fi

# remove duplicate path entries
export PATH=$(echo $PATH | awk -F: '
{ for (i = 1; i <= NF; i++) arr[$i]; }
END { for (i in arr) printf "%s:" , i; printf "\n"; } ')

# autocomplete ssh commands
complete -W "$(echo `cat ~/.bash_history | egrep '^ssh ' | sort | uniq | sed 's/^ssh //'`;)" ssh



##################################################
# Redirect bash built-in output to stdout	 #
##################################################

# TIME=$( { time YOUR_COMMAND_HERE; } 2>&1 ) ; echo $TIME



##################################################
# Startup programs				 #
##################################################

if [ "$USE_SCREEN" = "Y" ]; then
    if [ "$UID" -ne 0 ]; then
        if [ "$SHLVL" -eq 1 ]; then
            /usr/bin/screen -d -RR
        fi
    fi
fi

if [ -e "/usr/games/fortune" ]; then
    echo "Fortune: "
    /usr/games/fortune -a | ponysay -W i
    echo
fi

if [ -e "/usr/bin/uptime" ]; then
    echo "Uptime: ` /usr/bin/uptime`"
fi
# echo
# ~/bin/rc_sync.sh
# $HOME/bin/motd.pl



##################################################
# Various options to make $HOME comfy		 #
##################################################

if [ ! -d "${HOME}/bin" ]; then
    mkdir ${HOME}/bin
    chmod 700 ${HOME}/bin
    echo "${HOME}/bin was missing.  I created it for you."
fi

if [ ! -d "${HOME}/Documents" ]; then
    if ! [  -d "${HOME}/data" ]; then
        mkdir ${HOME}/data
        chmod 700 ${HOME}/data
        echo "${HOME}/data was missing.  I created it for you."
    fi
fi

if [ ! -d "${HOME}/tmp" ]; then
    mkdir ${HOME}/tmp
    chmod 700 ${HOME}/tmp
    echo "${HOME}/tmp was missing.  I created it for you."
fi



##################################################
# Stop Flash from tracking everything you do.	 #
##################################################

###### Brute force way to block all LSO cookies on Linux system with non-free Flash browser plugin
for A in ~/.adobe ~/.macromedia ; do ( [ -d $A ] && rm -rf $A ; ln -s -f /dev/null $A ) ; done




##################################################
##################################################
##################################################

######################################################################################################################################################
###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS ###### COMPLETIONS
######################################################################################################################################################

if [ -f ~/.bash-completions ]; then
    . ~/.bash-completions
fi

######################################################################################################################################################
###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS
######################################################################################################################################################

if [ -f ~/.bash-functions ]; then
    . ~/.bash-functions
fi

######################################################################################################################################################
###### ALIASES ###### ALIASES ###### ALIASES ###### ALIASES ###### ALIASES ###### ALIASES ###### ALIASES ###### ALIASES ###### ALIASES ###### ALIASES ######
######################################################################################################################################################

if [ -f ~/.bash-aliases ]; then
    . ~/.bash-aliases
fi

if [ -f ~/.bash-aliases-git ]; then
    . ~/.bash-aliases-git
fi

######################################################################################################################################################
###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ###### MISCELLANEOUS ######
######################################################################################################################################################

##################################################
# Bashrc greeting				 #
##################################################

###### from Jonathan's .bashrc file (by ~71KR117)
# greeting
# get current hour (24 clock format i.e. 0-23)
hour=$(date +"%H")
# if it is midnight to midafternoon will say G'morning
if [ $hour -ge 0 -a $hour -lt 12 ]
then
  greet="Good Morning, $USER. Welcome back."
# if it is midafternoon to evening ( before 6 pm) will say G'noon
elif [ $hour -ge 12 -a $hour -lt 18 ]
then
  greet="Good Afternoon, $USER. Welcome back."
else # it is good evening till midnight
  greet="Good Evening, $USER. Welcome back."
fi
# display greeting
echo ""
echo $greet
echo ""
if [ -e "/usr/bin/lynx" ] ; then
    weather
    echo ""
    forecast 80021
    echo ""
    echo "Sunrise/Sunset"
    suntimes
fi

#### Set up some pretty nifty ls colors

eval $( dircolors -b ~/.dircolors )

######################################################################################################################################################
#----- BASHRC ENDS HERE ------ BASHRC ENDS HERE ------ BASHRC ENDS HERE ------ BASHRC ENDS HERE ------ BASHRC ENDS HERE ------ BASHRC ENDS HERE ------
######################################################################################################################################################

fi	# end interactive check

######################################################################################################################################################
################################### MY BASHRC FILE ################################### MY BASHRC FILE ################################### MY BASHRC FILE
######################################################################################################################################################

## Clip before to restore

## !!! aw

function pophist() {
    history | sed 's/^[ \t]*[0-9]\+[ \t]\+[^ \t]\+[ \t]\+//' | head| sort | uniq -c | sort -rn | head
}

# PS1="LAPTOP \[\e[0m\][\[\e[32m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]:\[\e[35m\]\w\[\e[0;31m\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2 | xargs -I{} echo ' ({})')\[\e[0m\]]\\$ "


# Set Hadoop-related environment variables
export HADOOP_HOME=/usr/local/hadoop

# Set JAVA_HOME (we will also configure JAVA_HOME directly for Hadoop later on)
export JAVA_HOME=/usr/lib/jvm/java-6-sun

# Some convenient aliases and functions for running Hadoop-related commands
unalias fs &> /dev/null
alias fs="hadoop fs"
unalias hls &> /dev/null
alias hls="fs -ls"

# If you have LZO compression enabled in your Hadoop cluster and
# compress job outputs with LZOP (not covered in this tutorial):
# Conveniently inspect an LZOP compressed file from the command
# line; run via:
#
# $ lzohead /hdfs/path/to/lzop/compressed/file.lzo
#
# Requires installed 'lzop' command.
#
lzohead () {
    hadoop fs -cat $1 | lzop -dc | head -1000 | less
}

export PIG_CLASSPATH=~/jython/jython.jar:~/jython/Lib/
alias jython='java -jar ~/jython/jython.jar'


# Add Hadoop bin/ directory to PATH
export PATH=$PATH:$HADOOP_HOME/bin

set -o vi

export PERL_LOCAL_LIB_ROOT="~/perl5";
export PERL_MB_OPT="--install_base ~/perl5";
export PERL_MM_OPT="INSTALL_BASE~/perl5";
export PERL5LIB="~/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:~/perl5/lib/perl5";
export PATH="~/perl5/bin:$PATH";

export PERL_LOCAL_LIB_ROOT="~/perl5";
export PERL_MB_OPT="--install_base ~/perl5";
export PERL_MM_OPT="INSTALL_BASE=~/perl5";
export PERL5LIB="~/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:~/perl5/lib/perl5";
export PATH="~/perl5/bin:$PATH";

xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' > /dev/null 2>&1


if [ -e "/usr/share/bash-completion/bash_completion" ] ; then
    source /etc/bash_completion
elif [ -e "/etc/bash_completion" ] ; then
    source /etc/bash_completion
fi


# Try to force prompt to set. something interferes with it.

if [ -f ~/.bash-prompt ]; then
    source ~/.bash-prompt

    # Force prompt wrapping on the smaller terminals
    num_cols=`tput cols`
    if (( $num_cols < 100 )); then
        echo "Adjusting prompt for narrow terminal $num_cols"
        export PL_NL_AFTER_PATH=true
    else
        echo "Adjusting prompt for wide terminal $num_cols"
        export PL_NL_AFTER_PATH=false
    fi
fi
export PL_SHOW_RETURN_CODE=true

if [ -e ~/bin/resty ] ; then
    source ~/bin/resty
fi

