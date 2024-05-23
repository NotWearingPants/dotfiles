Import-Module "$PSScriptRoot\..\..\scripts\utils.psm1"

function Install-NPMPackages {
    $packagesToInstall = $args[0]

    'About to install {0} packages...' -f $packagesToInstall.length

    npm install -g $packagesToInstall

    'Finished installing all packages.'    
}

# TODO: symlink `.npmrc`

$packagesToInstall = Load-ListFile "$PSScriptRoot\packages.txt"
Install-NPMPackages $packagesToInstall

# setup packages that need more setup
. "$PSScriptRoot\..\eslint\install.ps1"
. "$PSScriptRoot\..\stylelint\install.ps1"
. "$PSScriptRoot\..\pug-lint\install.ps1"

Remove-Module utils
