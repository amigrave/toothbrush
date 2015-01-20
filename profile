# vim: ft=sh:
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LC_CTYPE=$LANG
export LC_COLLATE=C

# Set up main paths
export AMIGRAVE=$HOME/amigrave
export XDG_CONFIG_DIRS=$AMIGRAVE/config:$XDG_CONFIG_DIRS
export XDG_CONFIG_HOME=$HOME/.config

export ZDOTDIR=$AMIGRAVE/config/zsh

# export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
# export MPV_HOME=$XDG_CONFIG_HOME/mpv
# export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
# export INPUTRC=$XDG_CONFIG_HOME/inputrc
# export SCREENRC=$XDG_CONFIG_HOME/screenrc
# export IRBRC=$XDG_CONFIG_HOME/irbrc
# export LFTP_HOME=$XDG_CONFIG_HOME/lftp
# export MPV_HOME=$XDG_CONFIG_HOME/mpv
# export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
# export HTTPIE_CONFIG_DIR=$XDG_CONFIG_HOME/httpie
# export PSQLRC=$XDG_CONFIG_HOME/psqlrc
# export WGETRC=$XDG_CONFIG_HOME/wgetrc

# export XDG_CACHE_HOME=$HOME/.cache
# export DVDCSS_CACHE=$XDG_CACHE_HOME/dvdcss/
# export LESSHISTFILE=$XDG_CACHE_HOME/less_history
# export BZR_LOG=/dev/null

# export ERRFILE=$XDG_CACHE_HOME/xsession-errors.log

# if running bash
echo "test bashrc"
if [ -n "$BASH_VERSION" ]; then
    BASHRC="$AMIGRAVE/config/bash/bashrc"
    echo $BASHRC
    # include .bashrc if it exists
    if [ -f "$BASHRC" ]; then
        echo "YEAHS"
        . "$BASHRC"
    fi
fi

# set PATH with private's bin
if [ -d "$AMIGRAVE/bin" ] ; then
    PATH="$AMIGRAVE/bin:$PATH"
fi

# Homebrew
if [ -d "/usr/local/Cellar/coreutils" ]; then
    PATH="/usr/local/bin:$PATH"
    export PYTHONPATH=/usr/local/lib/python
    #PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
fi

if [ -d "/usr/local/lib/node_modules" ]; then
    NODE_PATH="/usr/local/lib/node_modules"
fi

# https://gist.github.com/cjbarnes18/4078704
# enable this for non-reparenting window managers
export _JAVA_AWT_WM_NONREPARENTING=1
