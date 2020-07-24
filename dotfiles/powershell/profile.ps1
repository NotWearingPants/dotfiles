# print the powershell version and username and computer name
# TODO: this also outputs in non-login shells, make it stop
& {
$versionMajor = $PSVersionTable.PSVersion.Major
$versionMinor = $PSVersionTable.PSVersion.Minor
$versionBits = if ([Environment]::Is64BitProcess) { 64 } else { 32 }
# "PowerShell v$versionMajor.$versionMinor $($versionBits)bit | $env:USERNAME@$env:COMPUTERNAME"
}

# set the prompt: `[time] user:cwd$ `
function prompt {
	$location = (Get-Location).Path.Replace($HOME, '~').Replace('C:', '').Replace('\', '/')
	$time = Get-Date -Format 'HH:mm'

	Write-Host -NoNewLine "[$time] "
	Write-Host -NoNewLine -ForegroundColor Green "$($env:USERNAME)"
	Write-Host -NoNewLine ":"
	Write-Host -NoNewLine -ForegroundColor Yellow "$location"
	"$ "
}

# exit using Ctrl+D
# NOTE: the `d` here must be lowercase
Set-PSReadlineKeyHandler -Key Ctrl+d -Function ViExit

New-Alias which Get-Command
New-Alias grep Select-String

# save the last result to $_
function Out-Default {
	# NOTE: $input is some sort of an enumerator, so we have to pipe it to get the result
	$input | Tee-Object -Variable result | Microsoft.PowerShell.Core\Out-Default

	# save the result into the $_ variable, but only if it's not an error
	if ($result -isNot [System.Management.Automation.ErrorRecord]) {
		$global:_ = $result
	}
}

function paste {
	$continuationPrompt = (Get-PSReadLineOption).ContinuationPrompt
	Get-Clipboard | ForEach-Object { "$continuationPrompt$_" }
	Get-Clipboard | Out-String | Invoke-Expression
}

function prevtime {
	$lastCommand = Get-History -Count 1
	$time = $lastCommand.EndExecutionTime - $lastCommand.StartExecutionTime
	'{0:mm\:ss\.fff}' -f $time
}

function publicip {
	((Invoke-WebRequest https://api.ipify.org/?format=json).content | ConvertFrom-Json).IP
}
