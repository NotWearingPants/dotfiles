#!/usr/bin/env sh

ROOT=$(realpath "$(dirname "$0")")

. "$ROOT/../../scripts/utils.sh"

# symlink the profile
mkdir -p "$HOME/.config/powershell"
symlink "$ROOT/profile.ps1" "$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"

# download offline help
pwsh -c 'Update-Help'
