# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

VISUAL=vim
EDITOR=vim

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=500000

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
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]$(date +%k:%M) \u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

#ZENBURN COLOR SCHEME FOR GNOME TERMINAL
export TERM=xterm-256color
gconftool-2 --set /apps/gnome-terminal/profiles/Default/foreground_color --type string "#DCDCCC"
gconftool-2 --set /apps/gnome-terminal/profiles/Default/background_color --type string "#1F1F1F"
gconftool-2 --set /apps/gnome-terminal/profiles/Default/bold_color --type string "#FFCFAF"
gconftool-2 --set /apps/gnome-terminal/profiles/Default/palette --type string "#000B13:#E89393:#4E4E4E:#F0DFAF:#8CD0D3:#C0BED1:#DFAF8F:#EFEFEF:#000B13:#E89393:#9ECE9E:#F0DFAF:#8CD0D3:#C0BED1:#DFAF8F:#FFFFFF"

export PYTHONSTARTUP="/home/orthez/.python.py"
export KLAMPT_DIR="/home/`whoami`/git/Klampt"
export KRISLIB_DIR="${KLAMPT_DIR}/Library/KrisLibrary/"
export PATH="/home/aorthey/anaconda/bin:$PATH"
export BLAS="/home/aorthey/git/blas-src/"
export LAPACK="/home/aorthey/git/lapack-src/lapack-3.5.0/liblapack.a"
export PATH="/usr/local/MATLAB/R2013a/bin:$PATH"
export MPP_PATH="/home/aorthey/devel/mpp/"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export PYTHONPATH=${PYTHONPATH}:"/home/aorthey/git/persistent-homology/Dionysus/build/bindings/python/"
export MPP_PATH="/home/`whoami`/devel/mpp/"
export DEVEL_DIR="/home/`whoami`/devel/hpp-stable"
source `openrave-config --share-dir`/openrave.bash
source `openrave-config --share-dir`/openrave_completion.bash
export PYTHONPATH=$PYTHONPATH:`openrave-config --python-dir`
export PYTHONPATH=$PYTHONPATH:"/home/aorthey/catkin/install/lib/python2.7/dist-packages/"
export MPP_PATH="/home/`whoami`/devel/mpp/"
export COIN_FULL_INDIRECT_RENDERING=1
export PATH="/usr/local/bin:$PATH"

source /usr/local/setup.bash
export OPENRAVE_PLUGINS=$OPENRAVE_PLUGINS:"/home/aorthey/catkin/install/share/openrave-0.9/plugins/"
export OPENRAVE_WPI_PATH="/home/`whoami`/git/openrave/sandbox/WPI/"
export ROS_DISTRO=indigo
source /home/aorthey/catkin_ws/devel/setup.bash
source /opt/ros/indigo/setup.bash
###AIST
export LD_LIBRARY_PATH=/home/aorthey/git/Klampt/Library/ode-0.11.1/ode/src/.libs/:$LD_LIBRARY_PATH
export PATH=/home/aorthey/workspace//bin:$PATH
export LD_LIBRARY_PATH=/home/aorthey/workspace//lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/home/aorthey/workspace//lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/home/aorthey/git/catkin_ws/devel/lib/pkgconfig:$PKG_CONFIG_PATH
export PYTHONPATH=/home/aorthey/workspace//lib/python2.7/site-packages:$PYTHONPATH

source $DEVEL_DIR/config.sh
export ROS_PACKAGE_PATH=/home/`whoami`/git/hrp2/:$ROS_PACKAGE_PATH
export ROS_PACKAGE_PATH=/home/`whoami`/devel/hpp-stable/src:$ROS_PACKAGE_PATH
export DISPLAY=':0.0'
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/:/usr/local/lib64/:/usr/lib/:/home/aorthey/devel/hpp-stable/install/lib/
#export OSG_FILE_PATH=/home/aorthey/devel/hpp-stable/src/OpenSceneGraph-Data/Images/:/home/aorthey/devel/hpp-stable/src/OpenSceneGraph-Data/

###############################################################################
#### Bash Shell Header 
###############################################################################
w
systemstats
ipstats
printline
###############################################################################

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

if [ -f ~/.bashrc_personal ]; then
  . ~/.bashrc_personal
fi

if [ -f ~/.bash/apt_tab_completion ]; then
  source ~/.bash/apt_tab_completion
fi

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
rotback(){
	SET1=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
        SET2=$(echo ${SET1:0:26}|rev)$(echo ${SET1:26:26}|rev)
	echo "-----------------------------------"
	echo "Backward"
	echo "-----------------------------------"
	echo ${SET1}
	echo ${SET2}
	echo "-----------------------------------"
	echo "BACK="`echo $1 | tr ${SET1} ${SET2}`
}
tablenumerical(){
	SET1=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
	echo "-----------------------------------"
	echo "TABLE LETTER - NUMERICAL"
	echo "-----------------------------------"
	echo ${SET1}
        for ((i=0;i<26;i++));
        do
            printf "%1s %3d %3d\n" ${SET1:$i:1} $i 
        done
	echo "-----------------------------------"
}


cp_pr()
{
   strace -q -ewrite cp -R -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}
cp_p()
{
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

#finger `whoami`
djvu2pdf(){
	FILE=`basename $1 .djvu`
	ddjvu -format=tiff $1 $FILE.tiff
	tiff2pdf -j -o $FILE.pdf $FILE.tiff
	rm -rf $FILE.tiff
}
#dependencies: 
#sudo apt-get install librsvg2-bin
svg2pdf(){
        FILE=`basename $1 .svg`
        rsvg-convert -f pdf -o $FILE.pdf $1
        echo "Output written to ${FILE}.pdf"
}
pts2mm(){
        echo "$1*0.3528" | bc -l
}
texgit(){
	rm -rf util-general.tex
	wget https://raw.github.com/orthez/latex-utils/master/util-general.tex
}

bmake(){
  mkdir -p build
  cd build 
  cmake .. 
  make -j5
  sudo make install
}
umake(){
  if [ -d $1 ]; then
    cd $1 
    cd build && cmake .. && make && make install
    cd ../..
  fi
}
uremake(){
  if [ -d $1 ]; then
    cd $1
    cd build && cmake .. && make clean && make && make install
    cd ../..
  fi 
}

ipstats(){
  printline
  echo 'TCP/UDP CONNECTIONS'
  printline
  netstat -anput 2>&1 | tail -n +5 | awk '{print $7}' | sort -k1,1 -k3,3 | sed 's#/# #' | column -t | uniq
}

systemstats(){
  printline
  echo 'SYSTEM STATUS'
  printline
  lsb_release -dc
  echo 'System      : '`uname -s`
  echo 'Kernel      : '`uname -r`
  echo 'Processor   : '`uname -p`
  echo 'GCC         : '`gcc --version|head -n1`
}

converttrim(){
  for file in "$@"
  do
    extension="${file##*.}"
    filename=$(basename "$file" .$extension)
    convert $file -trim $filename"-trim."$extension
    echo "$file -> $filename-trim.$extension"
  done
}
urdf2pdf(){
  FILE=`basename $1 .urdf`
  FILE_PDF="${FILE//[[:digit:]]/}".pdf
  urdf_to_graphiz $1
  apvlv ${FILE_PDF}
}

youtube2mp3(){
  sudo pip install --upgrade youtube-dl
  RES=$(youtube-dl --extract-audio --audio-format mp3 $1 |tee /dev/tty)
  if [[ ${RES} =~ ^.*(\[ffmpeg\]).*Destination:(.*mp3).*$ ]]; then
    FILENAME="$(echo -e "${BASH_REMATCH[2]}" | sed -e 's/^[[:space:]]*//')"
    printline
    echo "Created file: "
    ls "${FILENAME}"
    touch "${FILENAME}"
    printline
  fi
}

gdbrun(){
  gdb -ex 'set confirm off' -ex 'run' $1
}
makerun (){
  make $1 && gdbrun $1
}

ds(){
        if [ -d $1 ]; then
                printline
                du -sh $1*|sort -h
                printline
                du -sh $1
        fi 
}
