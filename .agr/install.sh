#!/bin/bash

# linux
# TODO: https://help.ubuntu.com/community/AppleKeyboard#Change%20Function%20Key%20behavior
# TODO: http://askubuntu.com/questions/7537/how-can-i-reverse-the-fn-key-on-an-apple-keyboard-so-that-f1-f2-f3-are-us
# TODO: http://askubuntu.com/questions/149971/how-do-you-remap-a-key-to-the-caps-lock-key-in-xubuntu
apt-get -y install mc screen tmux htop rsync vim telnet strace less netcat ncurses-term openssh-server python-pip dtrx multitail

pip install Baker bzr cdiff fabric fabtools flake8 git-qdiff httpie ipython jedi pudb pyquery pythonpy requests virtualenv pyrasite

# osx
# Some symlinks
ln -s ~/.dosbox/dosbox-0.74.conf Library/Preferences/DOSBox\ 0.74\ Preferences

# Change some defaults
defaults write -g ApplePressAndHoldEnabled -bool false

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

brew install coreutils --default-names
brew install findutils --default-names
brew install htop
chmod 6555 /usr/local/Cellar/htop/HEAD/bin/htop
sudo chown root /usr/local/Cellar/htop/HEAD/bin/htop

brew install ack autossh bazaar cd-discid colordiff flac fuse4x fuse4x-kext gdbm gettext glib htop id3lib id3v2 lame lha libao libiconv libid3tag libmikmod libogg libvorbis mad midnight-commander mikmod mpg321 mplayer node oniguruma p7zip pcre pkg-config pyqt qt renameutils s-lang sip smake sshfs tig uade unrar vorbis-tools wget xmp yasm zsh

pip install appscript
brew install homebrew/dupes/gdb # for pyrasite
PYTHON=/usr/local/bin/python3 brew install --with-python postgresql



# GIT: show author on rebase interactive:
# /usr/libexec/git-core/git-rebase--interactive
# https://gist.github.com/yurial/1909363
#  -git rev-list $merges_option --pretty=oneline --abbrev-commit\
#  +git rev-list $merges_option --pretty=">%h (%an <%ae>) %s"\
