#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

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

# create a link to the `profile.cmd` file that runs when cmd starts
New-Symlink "~\profile.cmd" "$PSScriptRoot\profile.cmd"

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
# TODO: install {Ubuntu (WSL), Windows Terminal, Windbg Preview, Nesbox, Minecraft, Minesweeper, Taki} from the Microsoft Store somehow
# TODO: install {Chrome, Edgium, VS Code, VS Code Insiders, Steam, Discord, Office, Zoom} (without scoop/chocolatey)

# setup everything
$PSScriptRoot\..\docker\install.ps1
$PSScriptRoot\..\git\install.ps1
$PSScriptRoot\..\npm\install.ps1
$PSScriptRoot\..\pip\install.ps1
$PSScriptRoot\..\powershell\install.ps1
$PSScriptRoot\..\sublime\install.ps1
$PSScriptRoot\..\vim\install.ps1
$PSScriptRoot\..\vscode\install.ps1

Remove-Module utils
