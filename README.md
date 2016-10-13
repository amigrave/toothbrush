Toothbrush
==========

This repository holds my **self contained** **unobtrusive** **dot(less)files**
that I published here to the request of friends and colleagues. I don't know if
the thing as a whole can be of any use to anyone given the fact that *dotfiles
are as personal as a toothbrush*, but if you find some interesting stuff in
here do not hesitate to send me some feedback! Who knows, this could motivate
me to bend all that mess carried from computers to computers since 20 years
toward something a bit more impersonated.


Self contained
--------------

The repository can be stored anywhere and the environment will be activated
when `start.sh` is launched. Everything needed for the environment is contained
in the folder, which is convenient when connecting to remote machines through
ssh because I can then literally bring my environment to the remote machine.
(see [sshrc](bin/sshrc))


Unobtrusive
-----------

The environment launched with `start.sh` will not interfere with the current
user's dotfiles. When launched, `start.sh` will point `$XDG_CONFIG_HOME` and
other environment variables to one of it's subfolder, and when the shell is
exited, the underlying configuration is back and untainted.


dot(less)files
--------------

By using `$XDG_CONFIG_HOME` and other tricks, I manage to keep my so-called
"dotfiles" actually without dots in their filenames which is of course an
unobjective preference. To make the environment persistent, it is possible to
trigger `start.sh -i` than will symlink the `start.sh` script itself to the
following locations (making backups of existing files if any):

    - ~/.bashrc
    - ~/.profile
    - ~/.xsessionrc (this one is experimental, use at your own risks)
    - ~/.zshrc

I doubt those could be of any use to anyone *as-is* because of the chaotic
structure and all the bloat accumulated since 20 years of linux usage, but
some friends asked me to have a look at them so here they are.


Platforms
---------

I try to maintain this environment for the following platforms:

- Linux Debian, Kali, Ubuntu and derivates
- OSX with Homebrew (assuming that the [GNU coreutils shadows the BSD versions]
(http://apple.stackexchange.com/a/69332))
- Cygwin (I use it rarely so don't expect it to work thoroughly -- like the rest :-)

with the following shells:

- bash
- zsh


What's cool ?
-------------

- [sshrc](bin/sshrc): allows you to connect to a remote host and bring the
environment with you.

    $ sshrc remote.host

    You might want to configure the remote location of
the uploaded config so just run `profile` (when running the environment) and
uncomment+edit the `SSHRC_LOCATION` value.

- [vimrc](bin/vimrc): my vimrc is not exceptional but it has some funny stuff
you'd might be interested to look at, unless you're an emacs user. Don't forget
to install the plugin the first time you run it ( `:PluginInstall` ). I also have
integration with terminator and vim/neovim. When <ctrl>-clicking on a filename
it will be opened in a vim/neovim instance whose `cwd` is equal to or is parent
of the file's path. This is very specific to my workflow tough as I use one
terminal tab per project and one vim instance in each tab's pane. An animated
gif is worth a thousand word:

TODO


Quick testing
-------------

If you just want to give a quick test:

    $ git clone --recursive https://github.com/amigrave/toothbrush; ./toothbrush/start.sh

To make it permanent at login:

    $ ~/toothbrush/start.sh -i

Note: `start.sh -i` will backup any existing file before doing the symlink


Warning
-------

`start.sh` and it's ability to be symlinked to `.profile`, `.bashrc`, ... is a
horrible hack. A clever hack if you ask me but a hack nevertheless.

If you install it with `start.sh -i` I suggest your first test without the
`.xsessionrc` symlink because I didn't tested it on all Display Managers (far
from it) and an error in the script during the loading of the X session will
result to a logout and a return to the DM login screen, hence it's a nightmare
to debug.


Note
-----

