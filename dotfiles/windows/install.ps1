#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# change settings in registry
reg import $PSScriptRoot\setup.reg

# TODO: disable sticky keys

# enable the telnet command
# TODO: check if the feature is already enabled, and skip this
Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient
# TODO: restart if needed

# enable WSL
# TODO: check if the feature is already enabled, and skip this
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# TODO: restart if needed

# create a link to the `profile.cmd` file that runs when cmd starts
New-Symlink '~\profile.cmd' "$PSScriptRoot\profile.cmd"

# force tls1.2 for increased security before running powershell scripts from the web
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

# install scoop
Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/ScoopInstaller/Install/master/install.ps1' | Invoke-Expression
# TOOD: we might need to reload the PATH here before we use scoop

# add additional buckets to scoop
scoop bucket add extras
scoop bucket add java
scoop bucket add versions
scoop bucket add nonportable
scoop bucket add games
scoop bucket add retools 'https://github.com/TheCjw/scoop-retools.git'
# hackishly add ./scoop-packages as a bucket named "local", because scoop doesn't handle local packages well
New-Folder '~\scoop\buckets\local'
New-Symlink '~\scoop\buckets\local\bucket' "$PSScriptRoot\scoop-packages"

# TODO: switch to using `winget`
# install scoop packages
$scoopPackagesToInstall = Load-ListFile "$PSScriptRoot\scoop-packages.txt"
scoop install $scoopPackagesToInstall

# install chocolatey
Invoke-WebRequest -UseBasicParsing 'https://chocolatey.org/install.ps1' | Invoke-Expression
# TOOD: we might need to reload the PATH here before we use choco

# install chocolatey packages
choco install -y '.\chocolatey-packages.config'

# make sure python3 takes precedence in path
scoop reset python
# make sure the latest java takes precedence in path
scoop reset openjdk

# TODO: use `rustup` installed by scoop to install `rustc` and `cargo`
# TODO: `cargo install bat` - doesn't compile

# TODO: install {Ubuntu (WSL), Windows Terminal, Windbg Preview, Nesbox, Minecraft, Minesweeper, Taki} from the Microsoft Store somehow
# TODO: install {Chrome, Edgium, VS Code, VS Code Insiders, Steam, Discord, Office, Zoom, pwsh} (without scoop/chocolatey)
# TODO: install {winget, Windows Terminal} if they're missing (old Windows version)

# TODO: get all installed apps using https://stackoverflow.com/questions/16452540/registry-path-to-find-all-the-installed-applications/62544878 and warn about those installed from outside of this script

# set windbg as the postmortem debugger
# TODO: how do i set it for 32bit programs as well? do i need to install windbg 32bit or can it be set to the 64bit windbg manually in the registry?
# TODO: maybe procdump instead?
windbg -I

# setup everything
. "$PSScriptRoot\..\docker\install.ps1"
. "$PSScriptRoot\..\git\install.ps1"
. "$PSScriptRoot\..\npm\install.ps1"
. "$PSScriptRoot\..\python\install.ps1"
. "$PSScriptRoot\..\powershell\install.ps1"
. "$PSScriptRoot\..\sublime\install.ps1"
. "$PSScriptRoot\..\vim\install.ps1"
. "$PSScriptRoot\..\vscode\install.ps1"
. "$PSScriptRoot\..\ssh\install.ps1"
. "$PSScriptRoot\..\mongodb\install.ps1"
. "$PSScriptRoot\..\editorconfig\install.ps1"
#. "$PSScriptRoot\..\hyper\install.ps1"

Remove-Module utils
