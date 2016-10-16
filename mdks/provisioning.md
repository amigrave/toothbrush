# AMIGrAve's Debian/Kali provisioning

## Description

My personal environment provisioning on Debian jessie or Kali 2 rolling release.

```docopt
Usage: mdk provisioning.md (--dektop | --server) [--miniconda-location=PATH] <host> <user>

Options:

--desktop               Setup a desktop machine
--server                Setup a server
--miniconda-location    Path to the miniconda installation (Defaults: ~/miniconda)
```

## Host preparation

The following operation can only be done on the host itself as Kali does not
start sshd by default and we only have a `root` account.

<mdk run-as='root' prompt-new_user="Enter username to add">
```sh
apt upgrade
apt install -y openssh-server
service ssh start
update-rc.d -f ssh enable 2 3 4 5

auth_keys="~/.ssh/authorized_keys"
echo "$ssh_key" >> $auth_keys  # TODO: find a better way

# prepare user
adduser $new_user
adduser $new_user sudo
su $new_user -c "mkdir -p ~/.ssh"
su $new_user -c "touch $auth_keys"
echo "$ssh_key" >> $auth_keys  # TODO: find a better way
```

For a password-less sudo use `visudo` and append at the last line:

    $new_user     ALL=(ALL) NOPASSWD: ALL

### Install dotfiles

<mdk run-as="$new_user">
```sh
ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts
git clone --recursive git@bitbucket.org:AMIGrAve/dotfiles.git ~/amigrave
~/amigrave/start.sh -i
mkdir -p ~/bin
```


## Install common stuff

<mdk run-as="root">

### Install common packages

```sh
# TODO: keep only necessary for server move the rest to desktop
apt install -y \
    vim whois build-essential linux-headers-amd64 linux-image-amd64 \
    zsh mc screen tmux htop rsync telnet strace less netcat ncurses-term \
    multitail silversearcher-ag git tig tree python-pip curl rename-utils \
    ncdu
chsh -s /bin/zsh
update-alternatives --set editor /usr/bin/vim.basic
```


### Install vmware tools if in a vmware box

If we are running under a vmware box, install vmware tools

<mdk run-as='root'>
```sh
# TODO: check if we're in a vmware box
# grep -i vmware /sys/class/dmi/id/sys_vendor
cd /usr/local/src
git clone https://github.com/rasa/vmware-tools-patches.git
cd vmware-tools-patches
./patched-open-vm-tools.sh
```

### Fix Edimax wifi dongle driver

<mdk confirm="Do you want to install the Edimax wifi driver">
```sh
cd /usr/local/src
apt install -y dkms
git clone https://github.com/pvaret/rtl8192cu-fixes.git
dkms add ./rtl8192cu-fixes
dkms install 8192cu/1.10
depmod -a
cp ./rtl8192cu-fixes/blacklist-native-rtl8192.conf /etc/modprobe.d/
```

## Install mdk base (Should be automatic)

### Install miniconda

In both cases (server or desktop) I'll use a miniconda installation.
Everything I need is in the official [miniconda mdk](https://mdk.sh/mdks/miniconda.md)

```sh
export MINICONDA=~/miniconda
cd /tmp

# TODO: Fetch the good platform
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-latest-Linux-x86_64.sh -b -p $MINICONDA
mkdir -p ~/bin
ln -s $MINICONDA/bin/conda ~/bin/
# conda create -y -n __mdk__ pip
```


## Server [--server]

## Desktop [--desktop]

Here's the desktop stuff


### Miscellaneous packages
```sh
sudo apt install -y chromium command-not-found qiv pidgin alsa-utils numlockx \
     rxvt-unicode-256color python-qt4 python-tk mtr terminator vim-gtk3 irssi scrot \
     xdotool xclip cmus sshfs feh mpv gtk-recordmydesktop mupdf
sudo update-alternatives --set x-www-browser /usr/bin/chromium
```

```sh
pip install --user cdiff howdoi escrotum pipdeptree
```

### Better fonts

The default font rendering in debian (hence Kali) is awful.
Using [a better method](http://www.webupd8.org/2013/06/better-font-rendering-in-linux-with.html) than crafting my own `fonts.conf`:

Set font style:

<mdk run-as='root'>
```sh
cd /tmp
wget http://ppa.launchpad.net/no1wantdthisname/ppa/ubuntu/pool/main/f/fontconfig-infinality/fontconfig-infinality_20130104-0ubuntu0ppa1_all.deb
dpkg -i fontconfig-infinality_20130104-0ubuntu0ppa1_all.deb
bash /etc/fonts/infinality/infctl.sh setstyle win7
```

Set rendering style:

<mdk change='/etc/profile.d/infinality-settings.sh'>
```diff
-USE_STYLE="DEFAULT"
+USE_STYLE="WINDOWS7"
# +USE_STYLE="WINDOWS7LIGHT"
# +USE_STYLE="UBUNTU"
```

Install additional fonts:

- powerline for the terminal and gvim:

```sh
# TODO: check if should be root ?
tmp=`mktemp -d`
cd $tmp
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
rm -rf $tmp
```

- dejavu for the rest

```sh
sudo apt install -y ttf-dejavu
```

### Install QTile


```sh
sudo apt install -y libxcb-render0-dev libffi-dev libcairo2-dev
sudo pip install virtualenv

qtile_venv=`readlink -f ~/.local/venvs/qtile`
mkdir -p $qtile_venv
virtualenv --system-site-packages $qtile_venv
$qtile_venv/bin/pip install xcffib cairocffi qtile # git+https://github.com/python-xlib/python-xlib.git pyautogui
mkdir -p ~/bin
ln -s $qtile_venv/bin/qtile ~/bin/
ln -s $qtile_venv/bin/qshell ~/bin/

# export MINICONDA=~/miniconda
# $MINICONDA/bin/conda create -y -n qtile pip
# $MINICONDA/envs/qtile/bin/pip install xcffib cairocffi qtile git+https://github.com/python-xlib/python-xlib.git pyautogui
# ln -s $MINICONDA/envs/qtile/bin/qtile ~/bin/
# ln -s $MINICONDA/envs/qtile/bin/qshell ~/bin/

```

<mdk run-as="root" put="/usr/share/xsessions/qtile.desktop" expand="django">
```ini
[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec={{ qtile_venv }}/bin/qtile
Type=Application
Keywords=wm;tiling
```

<mdk run-as="root" change="/etc/lightdm/lightdm.conf" mode="regex">
```diff
# Uncomment line:
# #sessions-directory=/usr/share/lightdm/sessions:/usr/share/xsessions:/usr/share/wayland-sessions
-#(sessions-directory=.+)
+\1
```

## Install common stuff


Check that for linux:

- TODO: https://help.ubuntu.com/community/AppleKeyboard#Change%20Function%20Key%20behavior
- TODO: http://askubuntu.com/questions/7537/how-can-i-reverse-the-fn-key-on-an-apple-keyboard-so-that-f1-f2-f3-are-us
- TODO: http://askubuntu.com/questions/149971/how-do-you-remap-a-key-to-the-caps-lock-key-in-xubuntu



### Install global python packages ?

```sh
pip install --user grip Baker bzr cdiff fabric fabtools flake8 git-qdiff httpie \
                   jedi pudb pyquery pythonpy requests virtualenv pyrasite pandas matplotlib numpy
pip install --user ipython==4.2.1  # version 5 uses prompt-toolkit which (at time of writing) does
                                   # not play well with pudb
```


## OSX

### Some symlinks
```sh
ln -s ~/.dosbox/dosbox-0.74.conf Library/Preferences/DOSBox\ 0.74\ Preferences
```

### For vm provisionning, don't forget to add config for seperate screen/keyboard

http://www.andrewhazelden.com/blog/2010/11/dual-users-on-one-mac-computer-using-vmware-fusion/

### Change some defaults
defaults write -g ApplePressAndHoldEnabled -bool false

### Google chrome

Google chrome does not play nice with Little Snitch:
https://fauxzen.com/little-snitch-google-chrome-ksfetch-issues/

```sh
defaults write com.google.Keystone.Agent checkInterval 604800
```

### Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

brew install coreutils --default-names
brew install findutils --default-names
brew install htop
chmod 6555 /usr/local/Cellar/htop/HEAD/bin/htop
sudo chown root /usr/local/Cellar/htop/HEAD/bin/htop

```sh
brew install ack autossh bazaar cd-discid colordiff flac fuse4x fuse4x-kext \
             gdbm gettext glib htop id3lib id3v2 lame lha libao libiconv \
             libid3tag libmikmod libogg libvorbis m-cli mad midnight-commander \
             mikmod mpg321 mplayer node oniguruma p7zip pcre pkg-config poppler \
             pyqt qt renameutils s-lang sip smake sshfs tig uade unrar \
             vorbis-tools wget xmp yasm zsh
```

### Casks

brew install Caskroom/cask/audacity

pip install appscript
brew install homebrew/dupes/gdb # for pyrasite
PYTHON=/usr/local/bin/python3 brew install --with-python postgresql

## Those fonts brings emoji and other unicode fonts

```sh
sudo apt install -y ttf-ancient-fonts
```

## TODO

GIT: show author on rebase interactive:

    /usr/libexec/git-core/git-rebase--interactive
    https://gist.github.com/yurial/1909363
     -git rev-list $merges_option --pretty=oneline --abbrev-commit\
     +git rev-list $merges_option --pretty=">%h (%an <%ae>) %s"\


### Postgres

http://russ.garrett.co.uk/2015/10/02/postgres-monitoring-cheatsheet/?utm_source=postgresweekly&utm_medium=email


## Add postgresql

<mdk run-as='root'>
```sh
apt-get install -y postgresql postgresql-server-dev-all
update-rc.d -f postgresql enable 2 3 4 5
service postgresql start
su - postgres -c "createuser -s $USER"
```

## Postinstall

```sh
vim -c ":PluginInstall"
chsh -s /bin/zsh  # asks password
```

## Atom

```sh
cd /tmp
wget https://atom.io/download/deb -Oatom.deb
sudo apt-get install gvfs-bin
sudo dpkg -i atom.deb
```

## Dev
```sh
sudo apt install -y ruby-dev libsqlite3-dev socat wkhtmltopdf libxml2-utils tidy jq apache2-utils gnuplot
```

## Sysadmin
```sh
sudo apt install -y iperf
```

### Install mailcatcher

```
sudo gem install mailcatcher
```

<mdk run-as="root" put="/etc/init/mailcatcher.conf">
```conf
description "Mailcatcher"

start on runlevel [2345]
stop on runlevel [!2345]

respawn

exec /usr/bin/env $(which mailcatcher) --foreground
```

## Odoo

```sh
sudo apt install -y \
    adduser node-less postgresql-client python python-dateutil python-decorator python-docutils \
    python-feedparser python-imaging python-jinja2 python-ldap python-libxslt1 python-lxml python-mako \
    python-mock python-openid python-passlib python-psutil python-psycopg2 python-babel python-pychart \
    python-pydot python-pyparsing python-pypdf python-reportlab python-requests python-suds python-tz \
    python-vatnumber python-vobject python-werkzeug python-xlwt python-yaml antiword graphviz ghostscript \
    postgresql python-gevent poppler-utils python-geoip geoip-database-contrib python-simplejson python-xlsxwriter \
    python-ofxparse python-psycogreen
```


## Odoo dev

```sh
sudo apt install -y \
    dnsutils phantomjs
pip install --user watchdog prettytable fabric fabtool
```
## NodeJS dev

<run run-as="root">
```sh
apt install -y nodejs npm
npm install -g diff-so-fancy eslint
```
