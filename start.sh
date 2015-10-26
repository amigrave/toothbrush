#!/bin/bash

# AMIGrAve's config startup
###########################

# This startup script is the single entry point for both manual startup and
# shell configuration. It means that this file can be symlinked to the
# following file in order to permanently install the config:
#
#       ~/.profile
#       ~/.bashrc
#       ~/.zshrc

# First get the current script directory location
if [ "$ZSH_VERSION" != "" ]; then
    # If sourced by zsh (eg: symlinked to ~/.zshrc)
    current_script=${(%):-%N}
    rcfile=zsh/zshrc
else
    current_script=${BASH_SOURCE[0]}
    rcfile=bash/bashrc
fi

# resolve potential symlinks
readlink=readlink
command -v greadlink > /dev/null && readlink=greadlink  # OSX
current_file=`$readlink -f $current_script`
current_dir=$( cd "$( dirname "$current_file" )" && pwd )
export AMIGRAVE=$current_dir
export DOTFILES=$AMIGRAVE/config/.xdg

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
            safe_link ~/.profile
            safe_link ~/.bashrc
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
elif [[ "$0" == ".profile" ]]; then
    source $DOTFILES/profile
else
    source $DOTFILES/$rcfile
fi
