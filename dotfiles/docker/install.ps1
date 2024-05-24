#requires -RunAsAdministrator

Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

# create a link in home to the docker client config
New-Symlink '~\.docker\config.json' "$PSScriptRoot\config.json"

# if `docker-machine` is installed, create a machine called "docker"
if (Get-Command -Name docker-machine -ErrorAction Ignore) {
	docker-machine create docker
}

Remove-Module utils
