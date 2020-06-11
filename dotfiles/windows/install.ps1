#requires -RunAsAdministrator

# change settings in registry
reg import $PSScriptRoot\setup.reg

# enable the telnet command
# TODO: check if the feature is already enabled, and skip this
Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient
# TODO: restart if needed

# enable WSL
# TODO: check if the feature is already enabled, and skip this
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# TODO: restart if needed

# TODO: install {Ubuntu (WSL), Windows Terminal, Windbg Preview, Nesbox, Minecraft, Minesweeper, Taki} from the Microsoft Store somehow

# create a link to the `profile.cmd` file that runs when cmd starts
# TODO: check if it already exists - fail if it exists and isn't our link, but pass if it is
New-Item -ItemType SymbolicLink "~\profile.cmd" -Target "$PSScriptRoot\profile.cmd"

# force tls1.2 for increased security before running powershell scripts from the web
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

# install scoop
Invoke-WebRequest -UseBasicParsing https://get.scoop.sh/ | Invoke-Expression
# TOOD: we might need to reload the PATH here before we use scoop

# add additional buckets to scoop
scoop bucket add extras
scoop bucket add java
scoop bucket add versions
scoop bucket add nonportable
scoop bucket add games
scoop bucket add retools https://github.com/TheCjw/scoop-retools.git
# hackishly add ./scoop-packages as a bucket named "local", because scoop doesn't handle local packages well
New-Item -Type Directory -Path ~\scoop\buckets\local
New-Item -Type SymbolicLink -Path ~\scoop\buckets\local\bucket -Target $PWD\scoop-packages

# install scoop packages
$scoopPackagesToInstall = (Select-String '^[^#]' $PSScriptRoot\scoop-packages.txt).Line
scoop install $scoopPackagesToInstall

# install chocolatey
Invoke-WebRequest -UseBasicParsing https://chocolatey.org/install.ps1 | Invoke-Expression
# TOOD: we might need to reload the PATH here before we use choco

# install chocolatey packages
choco install -y .\chocolatey-packages.config

# TODO: use `rustup` installed by scoop to install `rustc` and `cargo`

# TODO: install Chrome (without scoop/chocolatey)
# TODO: install VS Code (without scoop/chocolatey)
# TODO: install Steam (without scoop/chocolatey)
# TODO: install Discord (without scoop/chocolatey)
