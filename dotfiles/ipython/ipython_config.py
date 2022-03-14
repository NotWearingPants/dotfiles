import sys
import IPython

c = get_config()

c.InteractiveShell.confirm_exit = False

# editor for the `edit` magic (defaults to $EDITOR/vim/notepad)
#c.TerminalInteractiveShell.editor = 'subl -w'

c.InteractiveShellApp.extensions = [
	# autoreload all imported modules
	# https://ipython.readthedocs.io/en/stable/config/extensions/autoreload.html
	'autoreload',

	# autoimport
	'ipython_autoimport',
]
c.InteractiveShellApp.exec_lines = [
	# configure autoreload
	'%autoreload 2',

	# disable the bell
	# hack, after https://github.com/prompt-toolkit/python-prompt-toolkit/pull/1333 we can have `.enable_bell = False` instead, or set `PROMPT_TOOLKIT_BELL=0` in the env-vars
	'get_ipython().pt_app.output.bell = lambda: None',

	# tabs instead of spaces

	# override the Tab handler to insert an actual tab instead of 4 spaces
	'get_ipython().pt_app.key_bindings.get_bindings_for_keys(("c-i",))[0].handler = lambda event: event.current_buffer.insert_text("\t")',
	# make auto-indent also use tabs
	# to really fix this:
	#   hardcoded spaces: https://github.com/ipython/ipython/blob/1e7c2ca36d658fb2b835001a42d393d1e4e57386/IPython/core/interactiveshell.py#L3466-L3484
	#   hardcoded number 4 twice: https://github.com/ipython/ipython/blob/1e7c2ca36d658fb2b835001a42d393d1e4e57386/IPython/core/inputtransformer2.py#L718-L752
	#   hardcoded number 4 twice again, although not sure if this file is related: https://github.com/ipython/ipython/blob/1e7c2ca36d658fb2b835001a42d393d1e4e57386/IPython/core/inputsplitter.py#L179-L184
	'''
	get_ipython()._check_complete = get_ipython().check_complete
	def yay_tabs(code):
		code = code.replace('\t', ' ' * 4) # in order to divide the result by 4 we must first multiply by 4
		status, indent = get_ipython()._check_complete(code)
		if len(indent) % 4 == 0: # sometimes i use spaces by accident and indentation must be consistent
			indent = '\t' * (len(indent) // 4)
		return status, indent
	get_ipython().check_complete = yay_tabs
	del yay_tabs
	''',
	# enable prompt_toolkit's TabProcessor which renders the tab character as whitespace
	'''
	get_ipython().__extra_prompt_options = get_ipython()._extra_prompt_options
	def yay_tabs():
		from prompt_toolkit.layout.processors import TabsProcessor
		options = get_ipython().__extra_prompt_options()
		options['input_processors'].append(TabsProcessor(tabstop=4, char1=' ', char2=' '))
		return options
	get_ipython()._extra_prompt_options = yay_tabs
	del yay_tabs
	''',
]

# TODO: get python bitness
python_version = '.'.join(map(str, sys.version_info[:3]))
ipython_version = '.'.join(map(str, IPython.version_info[:-1]))
c.TerminalInteractiveShell.banner1 = f'Python {python_version} │ IPython {ipython_version}\n'

# https://gist.github.com/takluyver/85b33db0836cdcc4baf252fd81937fa7
class MyPrompts(IPython.terminal.prompts.Prompts):
	def in_prompt_tokens(self):
		return [
			(IPython.terminal.prompts.Token.PromptNum, str(self.shell.execution_count)),
			(IPython.terminal.prompts.Token.Prompt, '│ '),
		]

	def continuation_prompt_tokens(self, width):
		# `width` is the width of the current in-prompt
		# which may vary depending on the prompt num
		# so we pad with spaces to align the vertical bar
		# this is not responsible for actual indentation
		return [
			(IPython.terminal.prompts.Token.Prompt, '│ '.rjust(width, ' ')),
		]

	def out_prompt_tokens(self):
		return [
			(IPython.terminal.prompts.Token.OutPromptNum, str(self.shell.execution_count)),
			(IPython.terminal.prompts.Token.OutPrompt, '> '),
		]

c.TerminalInteractiveShell.prompts_class = MyPrompts
