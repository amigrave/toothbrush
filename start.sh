#!/bin/bash

# AMIGrAve's config startup
###########################

# This startup script is the single entry point for both manual startup and
# shell configuration. It means that this file can be symlinked to the
# following file in order to permanently install the config:
#
#       ~/.profile
#       ~/.bashrc
#       ~/.xsessionrc
#       ~/.zshrc

# We should be careful about the case we should load .profile
# because xsession init and login shells are a pain to debug!
load_profile=0

# First get the current script directory location
if [ "$ZSH_VERSION" != "" ]; then
    # In zsh context we can get the current file for sure
    current_script=${(%):-%N}
    # TODO: check if we could get a zsh env for ~/.profile
    rcfile=zsh/zshrc
elif [ "$BASH_SOURCE" != "" ]; then
    # In bash, try to get current file. Not always set unfortunately
    current_script=${BASH_SOURCE[0]}
    rcfile=bash/bashrc
else
    # Fallback if previous method fails we can't get the current script
    # path so we assume it's installed and linked to $AMIGRAVE/start.sh
    current_script="$HOME/.profile"
    load_profile=1
fi

if [ "$0" = ".profile" ]; then
    # Handle explicit case for .profile
    load_profile=1
elif [ "$0" = "/etc/X11/Xsession" ]; then
    # All X Display managers should source profile.
    # Watch out, the sheebang on Xsession is /bin/sh so we
    # must keep sh compatibility ! (eg: no [[ tests)
    # Of course, in case of DM we don't source the profile_interactive
    NOT_INTERACTIVE=1
    load_profile=1
fi

# resolve potential symlinks
readlink=readlink
command -v greadlink > /dev/null && readlink=greadlink  # OSX
current_file=`$readlink -f $current_script`
current_dir=$( cd "$( dirname "$current_file" )" && pwd )
export AMIGRAVE=$current_dir
export DOTFILES=$AMIGRAVE/config/.xdg
export XDG_CONFIG_HOME=$DOTFILES

# echo "AMIGRAVE($AMIGRAVE) - DOTFILES($DOTFILES)" >> /tmp/debug.log

if [ $load_profile -eq 1 ]; then
    . $DOTFILES/profile
    return
fi

function safe_link() {
   if [ -f $1 ]; then
       mv $1 $1_$(date +%F-%T)
   fi
   ln -s $current_file $1
}

use_bash=0
install=0
while getopts "bi" o; do
    case "${o}" in
        b) use_bash=1 ;;
        i)
            safe_link ~/.bashrc
            safe_link ~/.profile
            safe_link ~/.xsessionrc
            safe_link ~/.zshrc
            ;;
        *)
            echo "Usage: $0 [-b 'force bash'] [-i 'install']" 1>&2; exit 1;
            ;;
    esac
done
shift $((OPTIND-1))

if [[ "$0" == "$current_script" ]]; then
    # start.sh called explicitely
    [[ "$use_bash" == 1 ]] && export FORCE_BASH=1
    $AMIGRAVE/bin/shell
elif [ "$rcfile" != "" ]; then
    . $DOTFILES/$rcfile
else
    echo "We really want to debug this case: 0($0)" >> /tmp/debug.log
fi
