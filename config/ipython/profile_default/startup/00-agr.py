#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import sys

DOTFILES = os.getenv('DOTFILES')
if DOTFILES:
    sys.path.insert(0, DOTFILES)
