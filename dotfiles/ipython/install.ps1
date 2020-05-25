#requires -RunAsAdministrator

# create a link in the home directory to the `ipython_config.py` config file
# TODO: check if it already exists - fail if it exists and isn't our link, but pass if it is
# rm "$env:USERPROFILE\.ipython\profile_default\ipython_config.py"
New-Item -ItemType SymbolicLink "$env:USERPROFILE\.ipython\profile_default\ipython_config.py" -Target "$PSScriptRoot\ipython_config.py"
