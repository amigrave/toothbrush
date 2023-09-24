# Configuration file for ipython.
# run `ipython profile create` to generate a full configuration file
import os

os.environ['IPYTHONDIR'] = ''
c = get_config()  # NOQA

c.TerminalInteractiveShell.confirm_exit = False
c.BaseIPythonApplication.ipython_dir = os.path.join(os.getenv('XDG_CONFIG_HOME', '~/.config'), 'ipython')
