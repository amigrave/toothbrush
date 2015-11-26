# AMIGrAve's Debian / Kali provisioning

Provisionning on Debian 8.0+ or Kali2


```docopt
Usage: mdk provisioning.md (--dektop | --server) <host>
```

## Install vmware tools if in a vmware box

```bash
# TODO: check if we're in a vmware box
cd /tmp
git clone https://github.com/rasa/vmware-tools-patches.git
cd vmware-tools-patches
./patched-open-vm-tools.sh
```

## Fix Edimax wifi dongle driver

```bash
cd /usr/local/src
apt-get install build-essential dkms
git clone https://github.com/pvaret/rtl8192cu-fixes.git
dkms add ./rtl8192cu-fixes
dkms install 8192cu/1.10
depmod -a
cp ./rtl8192cu-fixes/blacklist-native-rtl8192.conf /etc/modprobe.d/
```

## Install mdk base (Should be automatic)

### Install miniconda

```bash
# export MINICONDA=~/miniconda2
cd /tmp
wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
bash Miniconda-latest-Linux-x86_64.sh -b
mkdir -p ~/bin
ln -s $MINICONDA/bin/conda ~/bin/
conda create -y -n __mdk__ pip
```

## Install common stuff

Check that for linux:

- TODO: https://help.ubuntu.com/community/AppleKeyboard#Change%20Function%20Key%20behavior
- TODO: http://askubuntu.com/questions/7537/how-can-i-reverse-the-fn-key-on-an-apple-keyboard-so-that-f1-f2-f3-are-us
- TODO: http://askubuntu.com/questions/149971/how-do-you-remap-a-key-to-the-caps-lock-key-in-xubuntu

### Common debian

```bash
apt-get -y install zsh mc screen tmux htop rsync vim telnet strace less netcat \
           ncurses-term openssh-server dtrx multitail htop silversearcher-ag \
           git tig
```

## Desktop debian

```
# XFCE
# apt-get install xfce4 xfce4-places-plugin xfce4-goodies
apt-get install ttf-dejavu terminator
```

Install powerline fonts

```bash
cd /tmp
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
```

### Install QTile

```bash
apt-get install libxcb-render0-dev libffi-dev libcairo2-dev

conda create -y -n qtile pip
$MINICONDA/envs/qtile/bin/pip install qtile


pip install escrotum


### Install global python packages ?

```bash
pip install grip Baker bzr cdiff fabric fabtools flake8 git-qdiff httpie ipython \
            jedi pudb pyquery pythonpy requests virtualenv pyrasite



```


## OSX

### Some symlinks
```bash
ln -s ~/.dosbox/dosbox-0.74.conf Library/Preferences/DOSBox\ 0.74\ Preferences
```

### For vm provisionning, don't forget to add config for seperate screen/keyboard

http://www.andrewhazelden.com/blog/2010/11/dual-users-on-one-mac-computer-using-vmware-fusion/

### Change some defaults
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

# Those fonts brings emoji and other unicode fonts
sudo apt-get install ttf-ancient-fonts

# GIT: show author on rebase interactive:
# /usr/libexec/git-core/git-rebase--interactive
# https://gist.github.com/yurial/1909363
#  -git rev-list $merges_option --pretty=oneline --abbrev-commit\
#  +git rev-list $merges_option --pretty=">%h (%an <%ae>) %s"\


### Postgres

http://russ.garrett.co.uk/2015/10/02/postgres-monitoring-cheatsheet/?utm_source=postgresweekly&utm_medium=email
