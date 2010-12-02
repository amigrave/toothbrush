# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

PADD=~/bin:~/local/bin/:/usr/local/sbin:/usr/sbin:/sbin
echo "$PATH" | grep "$PADD" > /dev/null || PATH="$PADD:$PATH"
unset PADD
export PATH

if [ "$COLORTERM" == "gnome-terminal" ]; then
    export TERM="gnome-256color"
elif [ "$TERM" == "screen" ]; then
    export TERM="screen-256color"
elif [ "$TERM" == "screen-bce" ]; then
    export TERM="screen-256color-bce-s"
elif [ $KONSOLE_DBUS_SESSION ]; then
    export TERM="konsole-256color"
fi

if [ "$OSTYPE" == "cygwin" ]; then
    termsetcolors
fi

export LESS="--no-init --ignore-case --LONG-PROMPT --silent --tabs=4 -R"
export LS_OPTIONS='--color=auto'
export VISUAL=vim
export EDITOR=vim
#export BROWSER=links
export BROWSER=google-chrome
export GREP_OPTIONS='--color=always'

# SDL Fullscreen second monitor
# export SDL_VIDEO_FULLSCREEN_HEAD=1
# export SDL_AUDIODRIVER=alsa

LANG=en_US.UTF-8
LC_COLLATE=C
export LC_COLLATE

usercolor="33"
if [ "$USER" == "amigrave" ]; then
	usercolor="35"
fi
hostcolor="34"
if [ "$HOSTNAME" == "agr" ]; then
	hostcolor="31"
fi
PS1='\[\033[$usercolor;1m\]\u\[\033[0m\]@\[\033[$hostcolor;1m\]\h \[\033[32;1m\]\w\[\033[0m\] [\[\033[35m\]\t\[\033[0m\]]\[\033[31m\]\$\[\033[0m\] '

[ -f ~/.dir_colors ] && eval `dircolors -b ~/.dir_colors `

