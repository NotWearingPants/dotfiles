#requires -RunAsAdministrator

# create a link in app data to the vimrc file
# TODO: check if it already exists - fail if it exists and isn't our link, but pass if it is
# rm "$env:USERPROFILE\AppData\Local\nvim\init.vim"
New-Item -ItemType SymbolicLink "$env:USERPROFILE\AppData\Local\nvim\init.vim" -Target "$PSScriptRoot\_vimrc2"
