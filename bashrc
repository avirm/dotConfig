###################################################################
## This is the .bashrc file for daq@clrppseport06.in2p3.fr
###################################################################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#alias visu="sudo /home/daq/Project/FirmwareTests/ServeurUdp/build/bin/visu"

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias setuproot612="source /home/daq/root-6.12.06-build/bin/thisroot.sh"
alias setuproot534="source /home/daq/root-5.34.36-build/bin/thisroot.sh"

alias sshCPU="ssh -Y root@192.168.100.11"
alias sshHV="ssh -Y daq2@192.168.100.9"
alias sshAvirmServer="ssh -Y admin@134.158.126.62"

alias setIPloc="sudo ifconfig enp0s31f6 192.168.100.10"
alias ipdel="sudo ip route del default"

alias rm="rm -i"

alias killdaq="ps -u daq | grep daqdpga | awk '{print \"kill -9 \"\$1}' | sh"

## VME
export DPGA=/home/daq/Project/goworkVME
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/daq/Project/goworkVME/pkg/linux_amd64/github.com/go-hep/croot/_lib/
source ../../root-5.34.36-ubuntu14/root/bin/thisroot.sh 
#export CGO_LDFLAGS_ALLOW="-(m64|rdynamic)"

## TCA
#export DPGA=/home/daq/Project/gowork
#setuproot612

export DIR_DCS=$DPGA
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DPGA/build/lib
export PATH=$DPGA/build/bin:/home/daq/intelFPGA_pro/18.0/qprogrammer/bin/:$PATH
alias daqdpga="daqdpga -i enp0s31f6 -g 1:2:3:4:5:6:7:8 -a -o 1 "

export GOPATH=$DPGA
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:/home/daq/go/go/bin

export GODAQPATH=/home/daq/Project/gowork/src/gitlab.in2p3.fr/avirm/analysis-go/rct/godaq

alias setGOPATHVME="export GOPATH=$DPGA/../goworkVME/"

alias bashrc="source .bashrc"

#  godaq -i /home/daq/datas/RunTest/MyFile_enp0s31f6@0_0.bin -mf 1 -ef 1 -notree -sigthres 800 
#
