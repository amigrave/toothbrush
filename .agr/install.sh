#!/bin/bash

mkdir -p ~/.vim/swap ~/.vim/backup

# linux
# TODO: https://help.ubuntu.com/community/AppleKeyboard#Change%20Function%20Key%20behavior
# TODO: http://askubuntu.com/questions/7537/how-can-i-reverse-the-fn-key-on-an-apple-keyboard-so-that-f1-f2-f3-are-us
# TODO: http://askubuntu.com/questions/149971/how-do-you-remap-a-key-to-the-caps-lock-key-in-xubuntu
apt-get -y install mc screen tmux htop rsync vim telnet strace less netcat ncurses-term openssh-server python-pip

pip install Baker bzr cdiff fabric fabtools flake8 git-qdiff httpie ipython jedi pudb pyquery pythonpy requests virtualenv pyrasite

# osx
pip install appscript
brew install homebrew/dupes/gdb # for pyrasite
