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

# force tls1.2 for increased security before running powershell scripts from the web
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

# install scoop
Invoke-WebRequest -UseBasicParsing https://get.scoop.sh/ | Invoke-Expression
# TOOD: we might need to reload the PATH here before we use scoop

# add the `extras` bucket to scoop
scoop bucket add extras

# scoop config 7ZIPEXTRACT_USE_EXTERNAL true

# install scoop packages
$scoopPackagesToInstall = (Select-String '^[^#]' $PSScriptRoot\scoop-packages.txt).Line
scoop install $scoopPackagesToInstall

# install chocolatey
Invoke-WebRequest -UseBasicParsing https://chocolatey.org/install.ps1 | Invoke-Expression
# TOOD: we might need to reload the PATH here before we use choco

# install chocolatey packages
choco install -y .\chocolatey-packages.config

# TODO: use `rustup` installed by scoop to install `rustc` and `cargo`
