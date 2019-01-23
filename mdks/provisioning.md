# AMIGrAve's provisioning for Ubuntu 18.04 and Kali

## Description

My personal environment provisioning on Debian jessie or Kali 2 rolling release.

```docopt
Usage: mdk provisioning.md [(--dektop | --server) | --module=<module>] <host> <user>
       mdk provisioning.md --list-modules

Options:

--desktop               Setup a desktop machine
--server                Setup a server
--module=<module>       Install a specific module
--list-modules          List available modules
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
ssh-keyscan -t rsa -H github.com >> ~/.ssh/known_hosts
git clone --recursive git@github.com:amigrave/toothbrush.git ~/amigrave
~/amigrave/start.sh -i
mkdir -p ~/bin
```


## Install common stuff

<mdk run-as="root">

### Install common packages

```sh
# TODO: keep only necessary for server move the rest to desktop
apt install -y \
    vim whois build-essential linux-headers-generic \
    zsh mc screen tmux htop rsync telnet strace less netcat-openbsd ncurses-term \
    multitail silversearcher-ag git tig tree python-pip python3-pip curl renameutils \
    ncdu dialog systemd-container debootstrap iselect pgcli
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

### Virtualbox

#### Fix mouse scrolling

An annoying bug in Virtual box linux guests is that the mouse scrolling is inaccurate if mouse is
moved at the same time:
https://forums.virtualbox.org/viewtopic.php?f=3&t=79002&sid=98b64e22a6d5fc02e50c157ce0c33b4f&start=15#p416603

So if we are in a VBox linux guest, install imwheel

<mdk run-as='root'>
```bash
dmidecode -t system | grep VirtualBox && apt install -y imwheel
```

#### Fix VBoxOGLcrutil.so

Version 6.x of VirtualBox introduxes a regression preventing QT 5.x to work when 3D acceleration is
activated:
https://www.virtualbox.org/ticket/18324#comment:3

```bash
sudo apt install patchelf
sudo patchelf --add-needed libcrypt.so.1 /usr/lib/x86_64-linux-gnu/VBoxOGLcrutil.so
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


### Install google chrome (Y/n)

Chromium is ok for most cases but I experienced some graphic rendering glitches under
virtual box which are not experienced with google chrome.

<mdk if="switch == 'Y'"/>
```sh
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
rm google-chome*.deb
sudo update-alternatives --set x-www-browser /usr/bin/google-chrome
```

<mdk if="switch == 'n'"/>
```sh
sudo apt install chromium
sudo update-alternatives --set x-www-browser /usr/bin/chromium
```

### Miscellaneous packages
```sh
sudo apt install -y command-not-found qiv pidgin alsa-utils numlockx howdoi golang-go \
     rxvt-unicode-256color python-tk mtr terminator vim-gtk3 irssi scrot \
     xdotool xclip cmus sshfs feh mpv gtk-recordmydesktop mupdf imagemagick unzip rar \
     blackbird-gtk-theme python3-qt5 python3-pyqt5.qtwebkit python3-pyqt5.qtsvg
```

### Sound

```sh
sudo apt install -y xmp
```

### Better fonts (TODO: still needed ?)

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

Next step is to [patch it in order to avoid X error messages](https://github.com/Infinality/fontconfig-infinality/pull/15/files)
<mdk run-as="root" patch="https://github.com/gamunu/fontconfig-infinality/commit/75a1ae15a15a005a965ba6a6bba890919ca4a005.patch">

Set rendering style:

<mdk run-as="root" change='/etc/profile.d/infinality-settings.sh'>
```diff
-USE_STYLE="DEFAULT"
+USE_STYLE="WINDOWS7"
# +USE_STYLE="WINDOWS7LIGHT"
# +USE_STYLE="UBUNTU"
```

NOTE: the previous operation is probably not needed anymore with this:
https://bugs.launchpad.net/ubuntu/+source/freetype/+bug/1722508/comments/36

<mdk run-as="root" change='/etc/environment'>
```diff
+FREETYPE_PROPERTIES="truetype:interpreter-version=35 cff:no-stem-darkening=1 
```

Install additional fonts:

- powerline for the terminal and gvim:

TODO: check if the following font should be installed too:
- https://github.com/ryanoasis/nerd-fonts
- https://github.com/ryanoasis/powerline-extra-symbols

```sh
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

## Those fonts brings emoji and other unicode fonts
sudo apt install -y ttf-ancient-fonts ttf-mscorefonts-installer
```

```

### Install QTile


```sh
sudo apt install -y qtile
```

## Install common stuff


Check that for linux:

- TODO: https://help.ubuntu.com/community/AppleKeyboard#Change%20Function%20Key%20behavior
- TODO: http://askubuntu.com/questions/7537/how-can-i-reverse-the-fn-key-on-an-apple-keyboard-so-that-f1-f2-f3-are-us
- TODO: http://askubuntu.com/questions/149971/how-do-you-remap-a-key-to-the-caps-lock-key-in-xubuntu



### Install python packages

```sh
pip install --user pipdeptree cdiff escrotum grip pudb httpie ipython
pip3 install --user pipdeptree flake8 jedi pudb jupyter ipython
# TODO: decide
# fabric fabtools pyquery pythonpy requests virtualenv pyrasite pandas matplotlib numpy
# pip install --user ipython==4.2.1  # version 5 uses prompt-toolkit which (at time of writing) does
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
su - postgres -c "createuser -s root"
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
sudo apt install -y libsqlite3-dev socat wkhtmltopdf libxml2-utils tidy jq gnuplot cloc \
                    ttyrec asciinema lolcat meld virtualenv
```

TODO: stuff in ~/bin (ws, hey, ...)
Do I use this ? -->  python-pygit2 python-fuse

### Mailcatcher

```sh
sudo gem install mailcatcher
```

<mdk run-as="root" put="/etc/systemd/system/mailcatcher.service">
```dosini
[Unit]
Description=MailCatcher Service
After=network.service

[Service]
Type=simple
ExecStart=/usr/local/bin/mailcatcher --foreground --smtp-port 25

[Install]
WantedBy=multi-user.target
description "Mailcatcher"
```

### MailHog

TODO: install go, make mailhog to /usr/local/bin/MailHog

[mdk run-as="root" put="/etc/systemd/system/mailhog.service"]
```dosini
[Unit]
Description=MailHog Email Catcher
After=syslog.target network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/MailHog
StandardOutput=journal
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

## Sysadmin

```sh
sudo apt install -y iperf
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
apt install -y nodejs npm node-babel-cli
npm install -g eslint jshint rapydscript
```

## Misc stuff

### Wine

<mdk as='root'>
```sh
dpkg --add-architecture i386
apt-get update
apt-get install wine32
```

### FCeux (just kept as example)

[FCEUX](http://www.fceux.com/web/home.html) is a featured rich cross platform
NES emulator.

We install both native and windows version (wine) because the native version is fast but does not
have the debugging features the windows version has.

#### Linux version

```sh
sudo apt -y install subversion scons libsdl1.2-dev libgtk-3-dev \
            liblua5.3-dev libgd-dev
cd /tmp
svn checkout svn://svn.code.sf.net/p/fceultra/code/fceu/trunk fceux
cd fceux  # mdk retains the current directory amongst code blocks
```

The file `SConstruct` should be modified in order to use gtk3:

<mdk change="SConstruct">
```diff
-  BoolVariable('GTK', 'Enable GTK2 GUI (SDL only)', 1),
-  BoolVariable('GTK3', 'Enable GTK3 GUI (SDL only)', 0),
+  BoolVariable('GTK', 'Enable GTK2 GUI (SDL only)', 0),
+  BoolVariable('GTK3', 'Enable GTK3 GUI (SDL only)', 1),
```

```sh
scons
sudo scons --prefix=/usr/local install
```

#### Wine version

```python
# FCEUX download page does not contain a wgetable link. let's fix this.
FCEUX_URL = 'http://www.fceux.com/web/download.html'
xpath = "//h3[contains(text(), 'Download')]/following::ul[1]/li[1]/a/@href"
url = mdk.scrape.url(FCEUX_URL).root.xpath(xpath)[0].split('/')

# Sanitize sourceforge url which lands on download page by default
if url[2] == 'sourceforge.net':
    url[2] = 'downloads.' + url[2]
if url[-1] == 'download':
    url.pop(-1)
url = '/'.join(url)
mdk.sh.wget(url)
# TODO: next
```

### CC65

<mdk as='root'>
```sh
cd /usr/local/src
git clone https://github.com/cc65/cc65.git
cd cc65
make
prefix=/usr/local make install
```

### Synergy

```sh
# TODO:
# - Get list of branches: https://github.com/symless/synergy/branches
# - List available builds: http://symless.com/nightly
# http://symless.com/files/nightly/synergy-v1.8.6-rc1-d0db743-MacOSX-x86_64.dmg
# http://symless.com/files/nightly/synergy-v1.8.6-rc1-d0db743-Linux-x86_64.deb
# http://symless.com/files/nightly/synergy-v1.8.6-rc1-d0db743-Windows-x64.msi
```
