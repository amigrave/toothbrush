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

export XDG_CONFIG_HOME=~/.config
export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
export MPV_HOME=$XDG_CONFIG_HOME/mpv
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export INPUTRC=$XDG_CONFIG_HOME/inputrc
export SCREENRC=$XDG_CONFIG_HOME/screenrc
export IRBRC=$XDG_CONFIG_HOME/irbrc
export LFTP_HOME=$XDG_CONFIG_HOME/lftp
export MPV_HOME=$XDG_CONFIG_HOME/mpv
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export HTTPIE_CONFIG_DIR=$XDG_CONFIG_HOME/httpie

export XDG_CACHE_HOME=~/.cache
export DVDCSS_CACHE=$XDG_CACHE_HOME/dvdcss/
export LESSHISTFILE=$XDG_CACHE_HOME/less_history

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# MacPorts
if [ -d "/opt/local" ]; then
    export PATH=/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:$PATH
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
