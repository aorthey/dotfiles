# some more ls aliases
TS='--color=auto --time-style='"'"'+|%d-%b-%Y -- %H:%M:%S|'"'"
alias lf='ls -alrhSF '$TS #all, listing, reverse, human-readable, sort-by-filesize, file-indicator
alias lrf='ls -alhSF '$TS #all, listing, human-readable, sort-by-filesize, file-indicator
alias ll='ls -alhF '$TS #all, listing, human-readable, file-indicator 
alias lrl='ls -alrhF '$TS #all, listing, reverse, human-readable, file-indicator
alias lt='ls -lAhFrt '$TS
alias lrt='ls -lAhFt '$TS
alias la='ls -A '$TS #almost-all
alias l='ls -CF '$TS #file-indicator, column-style (non-listing only)
alias 2..="cd ../.."
alias 3..="cd ../../.."
alias 4..="cd ../../../.."
alias printline='cat <(printf "%.0s-" {1..80}) <(echo)'
alias dustats='ds'
alias mv='mv -i'
alias px='ps aux|grep '
alias ht='history|tail -n15'
#sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
#bash single quotes: u can concatenate '...' with "..."
# because \' does not work in '...', we use "'" to represent single quotes
# similiarily, \" does not work either, so we use '"'.
#to write something like echo "'hallo'", we have to use
# 'echo "' + "'" + 'hallo' + "'" + '"'
alias example='echo "'"'"'hallo'"'"'"' #will write 'hallo' to console
alias fanwatch='watch -n 1 "cat /proc/acpi/ibm/fan|egrep '"'"'(status|speed|level)'"'"' && echo "" && sensors|grep "C""'
alias fandaemon='sudo modprobe -r thinkpad_acpi && sudo modprobe thinkpad_acpi'
alias wanip='lynx --dump http://ipecho.net/plain'
alias cwd='printf "%q\n" "$(pwd)"'
alias ccbuild='mkdir _build && cd _build && cmake ..'
alias makekrislib="cd ${KRISLIB_DIR} && sudo make install && cd ${KLAMPT_DIR} && sudo make -j5 install && cd ${KRISLIB_DIR}"
alias undounzip='zipinfo -1 $1 | xargs rm '
alias dishwasher="mplayer `locate DishWasher.mp3`"
alias ifprograms='socklist|sort -u -k7,7 -r'
alias permfindwx='find . -perm /o=x -perm /o=w ! -path "/sys/*" -exec ls -ld {} \; -exec chmod o-w {} \; -exec ls -lad {} \;'
alias rot13='tr a-zA-Z n-za-mN-ZA-M' 

alias vbn='vim +BlogNew'
alias vbl='vim +BlogList'
### set current working directories
#alias cdpaper='cd ~/git/15-orthey-ijrr/'
alias cdOpenHRP='cd /opt/grx/HRP2LAAS/bin/'
alias cdpaper='cd ~/git/papers/'
alias cdwork='cd ~/git/openrave/sandbox/WPI/'
alias cdHpp='cd ~/devel/hpp-stable/src/hpp_tutorial/script/'
alias cdMpp='cd ~/devel/mpp/mpp-path-planner'
alias cdkl='cd ${HOME}/git/Klampt/Library/KrisLibrary/'
alias cdk='cd ${HOME}/git/Klampt'
alias cdo='cd ${HOME}/git/orthoklampt'
alias cdob='cd ${HOME}/git/orthoklampt/build'
