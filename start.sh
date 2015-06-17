#!/bin/bash

current_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# export AMIGRAVE=$( dirname "$current_dir" )
export AMIGRAVE=$current_dir
source $AMIGRAVE/dotfiles/profile

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
# ln -s dotfiles/profile $HOME/.profile
# ln -s dotfiles/bash/bashrc $HOME/.bashrc

# Should be portable as much as possible, so get rid of this
# ln -s dotfiles/mc $HOME/.config/mc
# ln -s dotfiles/pudb $HOME/.config/pudb
# ln -s dotfiles/mc/skins  $HOME/.local/share/mc/skins/
# ln -s dotfiles/terminator $HOME/.config/terminator
# ln -s dotfiles/bazaar $HOME/.config/bazaar
# ln -s dotfiles/git $HOME/.config/git
# ln -s dotfiles/kid3.sourceforge.net $HOME/.config/kid3.sourceforge.net


# Debian QTile
# git clone https://github.com/qtile/qtile.git ~/.local/qtile
# sudo apt-get install python-dev libffi-dev python-pip python-trollius python-cairocffi libpangocairo-1.0-0 sudo apt-get install libxcb-render0-dev
# pip install --user xcffib


# Odoo
# sudo apt-get install postgresql
