#requires -RunAsAdministrator

# change settings in registry
regedit $PSScriptRoot\setup.reg

# enable the telnet command
# TODO: check if the feature is already enabled, and skip this
Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient

# enable WSL
# TODO: check if the feature is already enabled, and skip this
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# create a link to the `profile.cmd` file that runs when cmd starts
# TODO: check if it already exists - fail if it exists and isn't our link, but pass if it is
New-Item -ItemType SymbolicLink "$env:USERPROFILE\profile.cmd" -Target "$PSScriptRoot\profile.cmd"
