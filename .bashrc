# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# GIT bash completion
if [ -f ~/bin/git-completion.bash ]; then
    . ~/bin/git-completion.bash
fi

export XDG_CONFIG_HOME=~/.config
export MPV_HOME=$XDG_CONFIG_HOME/mpv
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export HTTPIE_CONFIG_DIR=$XDG_CONFIG_HOME/httpie
export DVDCSS_CACHE=~/.cache/dvdcss/

export HISTCONTROL=ignoreboth:erasedups  # no duplicate entries (ignorespace is for mc bug)
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize


PADD=~/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/share/npm/bin:/usr/local/ringojs/bin
echo "$PATH" | grep "$PADD" > /dev/null || PATH="$PADD:$PATH"
unset PADD
export PATH

if [ "$COLORTERM" == "rxvt-xpm" ]; then
    export TERM="rxvt-256color"
elif [ "$COLORTERM" == "gnome-terminal" ]; then
    export TERM="gnome-256color"
elif [ "$TERM" == "screen" ]; then
    export TERM="screen-256color"
elif [ "$TERM" == "screen-bce" ]; then
    export TERM="screen-256color-bce-s"
elif [ $KONSOLE_DBUS_SESSION ]; then
    export TERM="konsole-256color"
fi


if [ -f ~/.config/aliases ]; then
    . ~/.config/aliases
fi

export LESS="--no-init --ignore-case --LONG-PROMPT --silent --tabs=4 -R -F"
export LS_OPTIONS='--color=auto'
export VISUAL=vim
export EDITOR=vim
export BROWSER=google-chrome
export GREP_OPTIONS='--color=auto'

if [[ "$OSTYPE" == "linux" || "$OSTYPE" == "linux-gnu" ]]; then

    if [ -f ~/.config/aliases_linux ]; then
        . ~/.config/aliases_linux
    fi
    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # SDL Fullscreen second monitor
    # export SDL_VIDEO_FULLSCREEN_HEAD=1
    # export SDL_AUDIODRIVER=alsa

elif [ "$OSTYPE" == "cygwin" ]; then

    if [ -f ~/.config/aliases_cygwin ]; then
        . ~/.config/aliases_cygwin
    fi
    termsetcolors

elif [[ "$OSTYPE" =~ darwin* ]]; then

    if [ -f ~/.config/aliases_osx ]; then
        . ~/.config/aliases_osx
    fi
    export BROWSER=safari
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

fi


usercolor="33"
if [ "$USER" == "agr" ]; then
    usercolor="35"
fi
hostcolor="31"
if [ "$HOSTNAME" == "amigrave" ] || [ "$HOSTNAME" == "amigrave.local" ]; then
    hostcolor="34"
fi
PS1='\[\033[$usercolor;1m\]\u\[\033[0m\]@\[\033[$hostcolor;1m\]\h \[\033[32;1m\]\w\[\033[0m\] [\[\033[35m\]\t\[\033[0m\]]\[\033[31m\]\$\[\033[0m\] '

# Use this in order to get colors in man pages without termcap file
# export LESS_TERMCAP_mb=$'\E[01;31m'
# export LESS_TERMCAP_md=$'\E[01;31m'
# export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[01;44;33m'
# export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_us=$'\E[01;32m'

[ -f ~/.config/dir_colors ] && eval `dircolors -b ~/.config/dir_colors `

export HOSTING="amigrave.com"
