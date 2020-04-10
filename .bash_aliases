#bash single quotes: u can concatenate '...' with "..."
# because \' does not work in '...', we use "'" to represent single quotes
# similiarily, \" does not work either, so we use '"'.
#to write something like echo "'hello'", we have to use
# 'echo "' + "'" + 'hello' + "'" + '"'
alias example='echo "'"'"'hello'"'"'"' #will write 'hallo' to console

export NCORES="`grep \"^core id\" /proc/cpuinfo | sort -u | wc -l`"
alias makej="make -j${NCORES}"
alias printline='cat <(printf "%.0s-" {1..80}) <(echo)'

alias dustats='ds' ##size-sorted subfolder output
alias mv='mv -i'
alias px='ps aux|grep '
alias ht='history|tail -n15'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias fanwatch='watch -n 1 "cat /proc/acpi/ibm/fan|egrep '"'"'(status|speed|level)'"'"' && echo "" && sensors|grep "C""'
alias fandaemon='sudo modprobe -r thinkpad_acpi && sudo modprobe thinkpad_acpi'
alias wanip='lynx --dump http://ipecho.net/plain'
alias cwd='printf "%q\n" "$(pwd)"'
alias makekrislib="cd ${KRISLIB_DIR} && sudo make install && cd ${KLAMPT_DIR} && sudo make -j${NCORES} install && cd ${KRISLIB_DIR}"
alias undounzip='zipinfo -1 $1 | xargs rm '
alias ipython='ipython --no-confirm-exit'

alias dishwasher="mplayer `locate DishWasher.mp3`"
alias lplayer="mplayer -loop 0"

alias ifprograms='socklist|sort -u -k7,7 -r'
alias permfindwx='find . -perm /o=x -perm /o=w ! -path "/sys/*" -exec ls -ld {} \; -exec chmod o-w {} \; -exec ls -lad {} \;'
alias rot13='tr a-zA-Z n-za-mN-ZA-M' 
alias fgrep='egrep --line-number --no-messages --recursive --binary-files=without-match'
alias cp_noperm='cp -r --no-preserve=mode,ownership'

alias aistBuild="cd ~/git/mc_contact_controller/build/ && make && sudo make install && cd ~/git/mc_vrep/build/ && ./src/mc_vrep ../etc/mc_vrep.conf"
alias ccbuild='mkdir -p build && cd build && cmake ..'

TS='--color=auto --time-style='"'"'+|%d-%b-%Y -- %H:%M:%S|'"'"
alias lf='ls -alrhSF '$TS #all, listing, reverse, human-readable, sort-by-filesize, file-indicator
alias lfr='ls -alhSF '$TS #all, listing, human-readable, sort-by-filesize, file-indicator
alias ll='ls -alhF '$TS #all, listing, human-readable, file-indicator 
alias llr='ls -alrhF '$TS #all, listing, reverse, human-readable, file-indicator
alias lt='ls -AlhFrt '$TS #almost-all, listing, human-readable, file-indicator, reverse, sort-by-time
alias ltr='ls -AlhFt '$TS #almost-all, listing, human-readable, file-indicator, sort-by-time
alias la='ls -A '$TS #almost-all
alias l='ls -CF '$TS #file-indicator, column-style (non-listing only)
alias bwine='wine /home/aorthey/.wine32/drive_c/Program\ Files/Battle.net/Battle.net.exe'
alias cdwine='cd /home/aorthey/.wine32/drive_c/Program\ Files/'

alias vbn='vim +BlogNew'
alias vbl='vim +BlogList'
alias vbn2='vim +BlogSwitch 1 +BlogNew'
alias vbl2='vim +BlogSwitch 1 +BlogList'
alias vbn3='vim +BlogSwitch 2 +BlogNew'
alias vbl3='vim +BlogSwitch 2 +BlogList'
alias vbn4='vim +BlogSwitch 3 +BlogNew'
alias vbl4='vim +BlogSwitch 3 +BlogList'

alias cdOpenHRP='cd /opt/grx/HRP2LAAS/bin/'
alias cdpaper='cd ~/git/papers/'
alias cdwork='cd ~/git/openrave/sandbox/WPI/'
alias cdHpp='cd ~/devel/hpp-stable/src/hpp_tutorial/script/'
alias cdMpp='cd ~/devel/mpp/mpp-path-planner'
alias cdm='cd ${HOME}/git/MotionPlanningExplorerGUI'
alias cdmd='cdm && cd data'
alias cdmb='cdm && cd build'
alias cdk='cdm && cd libs/Klampt'
alias cdkl='cdm && cd libs/Klampt/Library/KrisLibrary/'
alias cdo='cdm && cd libs/ompl/src/ompl/'
alias cdob='cdm && cd libs/ompl/build/'
alias cdq='cdm && cd libs/ompl/src/ompl/geometric/planners/quotientspace/'
alias cdm='cd ${HOME}/git/MotionPlanningExplorerGUI'
alias explorerGUI='cdmb && cd ../libs/ompl/build && \
  cmake .. && make -j `nproc` && sudo make install && cdmb && makerunarg planner_gui'
alias explorerGUI_standalone='cdmb && cd ../libs/ompl/build && \
  cmake .. && make -j `nproc` && sudo make install && cdmb && makerunarg planner_standalone'
alias explorerGUI_debug='cdmb && cd ../libs/ompl/build/Debug && \
  cmake .. && make -j `nproc` && sudo make install && cdmb && makerunarg planner_standalone'

alias 2..="cd ../.."
alias 3..="cd ../../.."
alias 4..="cd ../../../.."

alias mps="sudo docker run -v /dev/snd:/dev/snd -it --rm --privileged --name mpsyt mpsyt"
