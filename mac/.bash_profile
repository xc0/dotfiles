
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
HISTSIZE=1000
HISTFILESIZE=2000

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# 写真.app を自動起動させない
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES
# kindle pw serial is G090G105611301AE
# password is fionab6d

#ssh port foward
#ssh xc0@xc0.pw -p 52622 -L 8900:127.0.01:5901 -f -N -C

# Xcode parallel processing
#system_profiler SPHardwareDataType
#defaults write com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks 2
# スクショの影を消す
#defaults write com.apple.screencapture disable-shadow -boolean true
#killall SystemUIServer


#export DISPLAY="localhost:0.0"
export LANG=ja_JP.UTF-8
export PS1='\[\e[34m\]\@ \[\e[33m\]\u@\h \[\e[32m\]\w\e[0m\n\$ '

alias rmds='find . -name .DS_Store | xargs rm'
alias rmdsgit='find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch'
alias git='rmdsgit; rmds; git'
alias ls='ls -G'
alias ll='ls -a -l'
alias vi='nvim'
alias nv='nvim'
alias kcs='xhost +;ssh -2 -C -Y c5901@st101.st.cs.kumamoto-u.ac.jp'
alias kcs1='xhost +;ssh -2 -C -Y c5901@st102.st.cs.kumamoto-u.ac.jp'
alias c1='xhost +;ssh -2 -C -Y c5901@calc1.st.cs.kumamoto-u.ac.jp'
alias c2='xhost +;ssh -2 -C -Y c5901@calc2.st.cs.kumamoto-u.ac.jp'
alias c3='xhost +;ssh -2 -C -Y c5901@calc3.st.cs.kumamoto-u.ac.jp'
alias c3='xhost +;ssh -2 -C -Y c5901@calc3.st.cs.kumamoto-u.ac.jp'
alias xc0='ssh -2 -C -Y -p 52622 xc0@xcd0.com'
alias wd="ssh -oHostKeyAlgorithms=+ssh-dss sshd@192.168.1.5"
alias pi='ssh -p52622 pi@192.168.1.2'
alias pic='ssh -p52622 pi@192.168.1.10'
alias spi='ssh pi@192.168.1.148'
alias tm="sudo mdutil -i off /Volumes/TimeMachine/Backups.backupdb"
alias lc="sudo chflags -R nouchg *"
alias vg="ssh -2 -C -Y -p52622 vagrant@LinuxMint.local"
alias vgb11="scp -r -2 -C -P52622 vagrant@LinuxMint.local:b11 ."
alias b11vg="scp -r -2 -C -P52622 ~/b11 vagrant@LinuxMint.local:"

#alias hy=`history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head`
alias gb='go build'
export ZDOTDIR=~/.dotfiles/zsh/

# mac pyenv setting
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PYTHON_H_DIR="$HOME/.pyenv/versions/2.7.11/include/python2.7"
eval "$(pyenv init -)"

# Go lang setting
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=/Users/xc0/work/go
export GOBIN=$GOPATH/bin
export PATH="$GOPATH/bin:$PATH"

PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

export PATH=$HOME/bin:$HOME/work/bin:$PATH

