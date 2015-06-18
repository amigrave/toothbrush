#!/bin/bash

current_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# export AMIGRAVE=$( dirname "$current_dir" )
export AMIGRAVE=$current_dir
source $AMIGRAVE/config/profile

SHELL=/bin/bash
if [ -x "$(command -v zsh)" ]; then
    SHELL=/bin/zsh
fi
export SHELL=$SHELL
if [ -x "$(command -v tmux)" ]; then
    tmux attach || $SHELL
else
    $SHELL
fi

# TODO: make installation mode
# mv $HOME/.profile $HOME/.profile_old
# ln -s config/profile $HOME/.profile
# ln -s config/bash/bashrc $HOME/.bashrc

# Should be portable as much as possible, so get rid of this
# ln -s config/mc $HOME/.config/mc
# ln -s config/pudb $HOME/.config/pudb
# ln -s config/mc/skins  $HOME/.local/share/mc/skins/
# ln -s config/terminator $HOME/.config/terminator
# ln -s config/bazaar $HOME/.config/bazaar
# ln -s config/git $HOME/.config/git
# ln -s config/kid3.sourceforge.net $HOME/.config/kid3.sourceforge.net


# Debian QTile
# git clone https://github.com/qtile/qtile.git ~/.local/qtile
# sudo apt-get install python-dev libffi-dev python-pip python-trollius python-cairocffi libpangocairo-1.0-0 sudo apt-get install libxcb-render0-dev
# pip install --user xcffib


# Odoo
# sudo apt-get install postgresql
