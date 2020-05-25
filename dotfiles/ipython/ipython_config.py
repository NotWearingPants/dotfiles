import sys
import IPython

c = get_config()

c.InteractiveShell.confirm_exit = False

# autoreload all imported modules
# https://ipython.readthedocs.io/en/stable/config/extensions/autoreload.html
# TODO: is there a better way to run these?
c.InteractiveShellApp.exec_lines = [
	'%load_ext autoreload',
	'%autoreload 2',
]

# TODO: get python bitness
python_version = f'{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}'
ipython_version = '.'.join(map(str, IPython.version_info[:-1]))
c.TerminalInteractiveShell.banner1 = f'Python {python_version}, IPython {ipython_version}\n'

# TODO: try using `c.TerminalInteractiveShell.prompts_class` to set `in` prompt to '>>>'
