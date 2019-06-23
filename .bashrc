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
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export PYTHONSTARTUP="/home/orthez/.python.py"
export KLAMPT_DIR="/home/`whoami`/git/Klampt"
export KRISLIB_DIR="${KLAMPT_DIR}/Library/KrisLibrary/"
export COIN_FULL_INDIRECT_RENDERING=1
export PATH="/usr/local/bin:$PATH"
export PATH="/home/`whoami`/git/mosek/8/tools/platform/linux64x86/bin:$PATH"


export LD_LIBRARY_PATH=/home/aorthey/git/Klampt/Library/ode-0.11.1/ode/src/.libs/:$LD_LIBRARY_PATH
export PYTHONPATH=/home/aorthey/workspace//lib/python2.7/site-packages:$PYTHONPATH

export SBL_DIR=$SBL_DIR:/usr/local/sbl/:/home/aorthey/git/sbl/
export PATH=$PATH:/usr/local/bin

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

version(){
  return `lsb_release -rs | sed 's/\.//'`
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
	FILE=`basename "${1}" .djvu`
	ddjvu -format=tiff "$FILE.djvu" "$FILE.tiff"
	tiff2pdf -j -o "$FILE.pdf" "$FILE.tiff"
	rm -rf "$FILE.tiff"
  echo "Output written to ${FILE}.pdf"
}
gv2pdf(){
  dot -Tpdf $1 -o ${1%%gv}pdf
}
#dependencies: 
#sudo apt-get install librsvg2-bin
svg2pdf(){
  FILE=`basename "${1}" .svg`
  rsvg-convert -f pdf -o "$FILE.pdf" "$1"
  echo "Output written to ${FILE}.pdf"
}
pts2mm(){
  echo "$1*0.3528" | bc -l
}
multicrop_png(){
  for var in "$@"
  do
    FILE=`basename "${var}" .png`
    convert "$FILE.png" -trim "$FILE.png" &>/dev/null
    echo "trim $FILE.png to $FILE.png"
  done
}
pdf2png_multi(){
  for var in "$@"
  do
    if [ ${var: -4} == ".pdf" ]; then
      FILE=`basename "${var}" .pdf`
      convert -density 150 "$FILE.pdf" -trim -quality 100 "$FILE.png"
      echo "converted $FILE.pdf to $FILE.png"
    else
      echo "Ignored file ${var}"
    fi

  done
}
pdf2png(){
  FILE=`basename "${1}" .pdf`
  convert -density 150 "$FILE.pdf" -trim -quality 100 "$FILE.png"
  echo "converted $FILE.pdf to $FILE.png"
}
png2pdf(){
  for var in "$@"
  do
    FILE=`basename "${var}" .png`
    convert "$FILE.png" -trim -quality 100 "$FILE.pdf"
    pdfcrop "$FILE.pdf" --margin 5 "$FILE.pdf" &>/dev/null
    echo "converted $FILE.png to $FILE.pdf"
  done
}
pdfcrop_multi(){
  for var in "$@"
  do
    FILE=`basename "${var}" .pdf`
    pdfcrop "$FILE.pdf" --margin 5 "$FILE.pdf" &>/dev/null
    echo "pdfcrop $FILE.pdf to $FILE.pdf"
  done
}
png2pdfmargin(){
  for var in "$@"
  do
    FILE=`basename "${var}" .png`
    convert "$FILE.png" -quality 100 "$FILE.pdf"
    pdfcrop "$FILE.pdf" --margin "0 -250 0 -150" "$FILE.pdf" &>/dev/null
    echo "converted $FILE.png to $FILE.pdf"
  done
}
texgit(){
	rm -rf util-general.tex
	wget https://raw.github.com/orthez/latex-utils/master/util-general.tex
}

kalkbrenning(){
  ## load all kalkbrenner songs in Music folder and play them on loop
  cd ~/Music/
  pwd
  CLOUD="`find . -type f -iname \*cloud\ rider\* -not -iname \*mothertrucker\*`"
  TRKR="`find . -iname \*mothertrucker\* -not -iname \*cloud\*`"
  FEED="`find . -iname \*feed\ your\ head\* -not -iname \*mothertrucker\*`"
  printline
  echo "Found Songs:"
  echo "${FEED}" 
  echo "${CLOUD}" 
  echo "${TRKR}"
  printline
  mplayer -loop 0 "${FEED}" "${CLOUD}" "${TRKR}"
}

rvim(){
  IFILE="https://ia600403.us.archive.org/18/items/RockyThemeSong/Rocky%20theme%20song.ogg"
  cd ~/Music/
  wget -nc $IFILE
  FILE=$(basename "$IFILE")
  mplayer -loop 0 "${FILE//%20/ }" </dev/null &>/dev/null&
  cd -
  vim
  pkill mplayer
}

bmake(){
  mkdir -p build
  cd build 
  cmake .. 
  make -j5
  sudo make install
}
umake(){
  if [ -d "$1" ]; then
    cd "$1"
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
#take all ppm files in folder, convert to avi movie, remove all ppm files
#input: name of movie file
ppm2avi(){
  for f in *.ppm; do convert -quality 100 $f  `basename $f .ppm`.jpg; done
  mencoder "mf://*.jpg" -o $1 -ovc lavc 
  rm -rf *.ppm
  echo "Created movie $1 from ppm files."
}
urdf2pdf(){
  FILE=`basename $1 .urdf`
  #FILE_PDF="${FILE//[[:digit:]]/}".pdf
  FILE_PDF="${FILE//@(_*)/}.pdf"
  rm -rf $FILE_PDF
  urdf_to_graphiz $1
  apvlv $FILE_PDF
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

gdbrun (){
  gdb -q -ex 'set confirm off' -ex 'run' --args $@
}
makerun (){
  make $1 && gdbrun $1
}
makerunarg (){
  make -j5 $1 && gdbrun $@
}

ds(){
        if [ -d $1 ]; then
                printline
                du -sh $1*|sort -h
                printline
                du -sh $1
        fi 
}

grepcpp(){
  grep -Rs --include \*.cpp --include \*.h --include \*.hpp --include \*.ipp $1 .
}
grepcppheader(){
  grep -Rs --include \*.h --include \*.hpp --include \*.ipp $1 .
}

dae2stl(){
  if [ ${1: -4} == ".dae" ]; then
    FOUT=`basename $1 .dae`.stl
    ctmconv $1 $FOUT
  else
    echo "Not a dae file"
  fi
}

dae2tri(){
  if [ ${1: -4} == ".dae" ]; then
    FOUT=`basename $1 .dae`.stl
    ctmconv $1 $FOUT
    converter.py -i $FOUT -e tri
    rm -rf $FOUT
  else
    echo "Not a dae file"
  fi
}

off2tri(){
  for file in "$@"
  do
    # extension="${file##*.}"
    # filename=$(basename "$file" .$extension)
    # convert $file -trim $filename"-trim."$extension
    # echo "$file -> $filename-trim.$extension"
    if [ ${file: -4} == ".off" ]; then
      FOUT=`basename ${file} .off`.stl
      ctmconv ${file} $FOUT && stl2tri $FOUT
    fi
  done
}
stl2tri(){
  if [ ${1: -4} == ".stl" ]; then
    converter.py -i $1 -e tri
  else
    echo "Not an STL file"
  fi
}
pdf2words(){
  echo "This PDF has $(pdftotext "$1" - | tr -d '.' | wc -w) words"
}

stl2off(){
  if [ ${1: -4} == ".stl" ]; then
    FOUT=`basename $1 .stl`.off
    meshlabserver -i $1 -o $FOUT
  else
    echo "Not an STL file"
  fi
}

db2png(){
  ~/git/orthoklampt/scripts/ompl_benchmark_statistics_simple.py $1 -p benchmark.pdf
  convert -density 150 benchmark.pdf -trim -quality 100 benchmark.png
  apvlv benchmark.pdf
}


###############################################################################
#### gitpaperclone: clone a particular single branch from a git repo
#### _comp_git_clonepaper: allow <Tab> to make a query to determine all
####    available branches. Then cache them and return them to cmd line
###############################################################################
gitpaperclone()
{
  git clone --single-branch -b $1 --recursive git@bitbucket.org:aorthey/papers.git $1
}
_comp_git_clonepaper()
{
  local cur prev 
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  if [ -z "$_gitclonepaper_complete_goals" ]; then
    opts=`git ls-remote --heads git@bitbucket.org:aorthey/papers.git`
    opts=$(echo $opts | tr ' ' "\n")
    opts=($(echo $opts |  awk -F' ' ' { for (i = 2; i <= NF; i+=2) print $i; exit } '))
    for (( i = 0 ; i < ${#opts[@]} ; i++ )) do 
      opts[i]=`basename ${opts[$i]}`
    done
    _gitclonepaper_complete_goals=`echo ${opts[@]}`
  fi

  if [[ ${cur} == * ]] ; then
      COMPREPLY=( $(compgen -W "${_gitclonepaper_complete_goals}" -- ${cur}) )
      return 0
  fi
  return 0
}
complete -F _comp_git_clonepaper gitpaperclone

###############################################################################
#### Bash Shell Header 
###############################################################################
w
systemstats
ipstats
printline
###############################################################################
source /opt/ros/melodic/setup.bash
source /home/`whoami`/catkin_ws/devel/setup.bash

export WINEARCH=win32
export WINEPREFIX=~/.wine32

source ~/ws_moveit/devel/setup.bash
