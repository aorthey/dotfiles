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
HISTSIZE=10000

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

# \u username 
# \h hostname
# \w cur dir
# \$(date +%k:%M:%S)

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}$(date +%k:%M) \u@\h:\w> '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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
TS='--color=auto --time-style='"'"'+|%d-%b-%Y -- %H:%M:%S|'"'"
alias ll='ls -alrhSF '$TS #all, listing, reverse, human-readable, sort-by-filesize, file-indicator
alias lrl='ls -alhSF '$TS #all, listing, human-readable, sort-by-filesize, file-indicator
alias lt='ls -lAhFrt '$TS
alias lrt='ls -lAhFt '$TS
alias la='ls -A '$TS #almost-all
alias l='ls -CF '$TS #file-indicator, column-style (non-listing only)
alias 2..="cd ../.."
alias 3..="cd ../../.."
alias 4..="cd ../../../.."


alias mv='mv -i'

alias ht='history|tail -n15'

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#aorthez custom commands
source ~/.bash/apt_tab_completion

#bash single quotes: u can concatenate '...' with "..."
# because \' does not work in '...', we use "'" to represent single quotes
# similiarily, \" does not work either, so we use '"'.
#to write something like echo "'hallo'", we have to use
# 'echo "' + "'" + 'hallo' + "'" + '"'

alias example='echo "'"'"'hallo'"'"'"' #will write 'hallo' to console
alias fanwatch='watch -n 0.2 "cat /proc/acpi/ibm/fan|egrep '"'"'(status|speed|level)'"'"' && echo "" && sensors|grep "C""'
alias fandaemon='sudo modprobe -r thinkpad_acpi && sudo modprobe thinkpad_acpi'
alias wanip='curl -s http://whatismyip.org && echo'

#find all files which have ?wx permission for others and change them to ?-x
#this should add more security to the system, because you need root access
#to insert malicious code into an executable
alias permfindwx='find . -perm /o=x -perm /o=w ! -path "/sys/*" -exec ls -ld {} \; -exec chmod o-w {} \; -exec ls -lad {} \;'

alias rot13='tr a-zA-Z n-za-mN-ZA-M' 

rotn(){
	N=$1
	SET1=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
	#substrings: ${$STRING:start:duration} --> ${"rotnforlife":3:2}=nf
	SET2=${SET1:$N:26-$N}${SET1:0:$N}${SET1:26+$N:54-$N}${SET1:26:$N}
	echo "-----------------------------------"
	echo "Caesar cipher rotation ${N}"
	echo "-----------------------------------"
	echo ${SET1}
	echo ${SET2}
	echo "-----------------------------------"
	echo "ROT[${N}]="`echo $2 | tr ${SET1} ${SET2}`
}
reverse(){
	echo `echo $1 | sed '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//'`
}
rotall(){
	for((N=0;N<26;N++)) do
		SET1=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ;
		SET2=${SET1:$N:26-$N}${SET1:0:$N}${SET1:26+$N:54-$N}${SET1:26:$N};
		echo "ROT[${N}]="`echo $1 | tr ${SET1} ${SET2}`;
	done;

}
VISUAL=vim
EDITOR=vim
#android programming env
PATH=$PATH:/home/orthez/workspace/android-sdk-linux/platform-tools:/home/orthez/workspace/android-sdk-linux/tools
export PATH=$PATH:/opt/openrobots/bin:/opt/openrobots/sbin

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/openrobots/lib/pkgconfig
source /opt/ros/fuerte/setup.bash

#finger `whoami`
w
