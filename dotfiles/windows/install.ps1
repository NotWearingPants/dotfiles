#requires -RunAsAdministrator

# change settings in registry
regedit $PSScriptRoot\setup.reg

# enable the telnet command
Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient

# enable WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# create a link to the `profile.cmd` file that runs when cmd starts
New-Item -ItemType SymbolicLink "$env:USERPROFILE\profile.cmd" -Target "$PSScriptRoot\profile.cmd"
