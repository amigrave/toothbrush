# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export LANG=en_US.utf-8
export LC_ALL=$LANG
export LC_CTYPE=$LANG
export LC_COLLATE=C

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
