# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

PADD=~/bin:~/local/bin/:/usr/local/sbin:/usr/sbin:/sbin:/var/lib/gems/1.8/bin
echo "$PATH" | grep "$PADD" > /dev/null || PATH="$PADD:$PATH"
unset PADD
export PATH

#export TERM=xterm-256color
#export TERM=gnome-256color
#export TERM=xterm-256color
#if [ "$TERM" == "xterm" ]; then
#    # No it isn't, it's gnome-terminal
#    export TERM=xterm-256color
#fi
export LESS="--no-init --ignore-case --LONG-PROMPT --silent --tabs=4 -R"
export LS_OPTIONS='--color=auto'
export VISUAL=vim
export EDITOR=vim
#export BROWSER=links
export BROWSER=google-chrome

# SDL Fullscreen second monitor
# export SDL_VIDEO_FULLSCREEN_HEAD=1
# export SDL_AUDIODRIVER=alsa

LANG=en_US.UTF-8
LC_COLLATE=C
export LC_COLLATE

C=1
[ "$UID" = "0" ] && C=44
usercolor="33"
if [ "$USER" = "amigrave" ]; then
	usercolor="35"
fi
hostcolor="34"
if [ "$HOSTNAME" = "agr" ] || [ "$HOSTNAME" = "dev" ] || [ "$HOSTNAME" = "mov" ]; then
	hostcolor="31"
fi
PS1='\[\033[$usercolor;1m\]\u\[\033[0m\]@\[\033[$hostcolor;1m\]\h \[\033[32;1m\]$PWD\[\033[0m\] [\[\033[35m\]\#\[\033[0m\]]\[\033[31m\]\$\[\033[0m\] '

[ -f ~/.dir_colors ] && eval `dircolors -b ~/.dir_colors `

