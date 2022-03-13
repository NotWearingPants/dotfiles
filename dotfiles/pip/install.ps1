# TODO: warn about installed packages which are not in the list
pip3 install -r "$PSScriptRoot\requirements.txt"
pip2 install -r "$PSScriptRoot\requirements.txt"

# setup ipython
. "$PSScriptRoot\..\ipython\install.ps1"
