#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys

DOTFILES = os.environ['DOTFILES']
if DOTFILES:
    sys.path.insert(0, DOTFILES)
