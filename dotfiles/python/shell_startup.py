try:
    import readline
    import rlcompleter
    import atexit
    import os
    import sys
except ImportError:
    pass
else:
    histfile = os.path.join(os.environ["XDG_CACHE_HOME"], "python_history")
    readline.parse_and_bind("tab: complete")
    if os.path.isfile(histfile):
        readline.read_history_file(histfile)
    atexit.register(readline.write_history_file, histfile)
    sys.ps1 = '\033[01;33m>>>\033[00m '
    del os, histfile, readline, rlcompleter, atexit, sys
