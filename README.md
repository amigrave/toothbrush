AMIGrAve's config
=================

This repository holds my self contained unobstrusive dot(less)files.

I doubt those could be of any use to anyone *as-is* because of the chaotic
structure and all the bloat accumulated since 20 years of linux usage, but
some friends asked me to have a look at them so here they are.


What's cool ?
-------------

- The config is completely self contained and does not touch existing config
- `sshrc` allows you to connect to a host and bring your configuration with you

    $ sshrc remote.host


Testing
-------

If you just want to give a quick test:

    $ git clone https://github.com/amigrave/dotlessfiles ~/amigrave
    $ ~/amigrave/start.sh

To make permanent at login:

    $ ~/amigrave/start.sh -i

Note: `-i` will just rename any ~/.bashrc and/or ~/.zshrc and link to the new ones


Installation
------------

Single line installation:

    $ wget -O- https://raw.githubusercontent.com/amigrave/dotlessfiles/master/start.sh | bash


Note
----

On OSX it is assumed that you use the GNU tools and not their BSD
