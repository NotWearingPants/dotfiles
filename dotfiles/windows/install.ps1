#requires -RunAsAdministrator

# change settings in registry
regedit $PSScriptRoot\setup.reg

# enable the telnet command
Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient

# enable WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
