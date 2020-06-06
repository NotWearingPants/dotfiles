#requires -RunAsAdministrator

# create a link documents to the profile file
# TODO: check if it already exists - fail if it exists and isn't our link, but pass if it is
# rm "~\Documents\WindowsPowerShell\profile.ps1"
New-Item -ItemType Directory "~\Documents\WindowsPowerShell"
New-Item -ItemType SymbolicLink "~\Documents\WindowsPowerShell\profile.ps1" -Target "$PSScriptRoot\profile.ps1"
