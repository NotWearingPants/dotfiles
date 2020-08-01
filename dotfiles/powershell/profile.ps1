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
	$time = Get-Date -Format 'HH:mm'
	$username = if ($IsWindows) { $env:USERNAME } else { $env:USER }
	$location = (Get-Location).Path.Replace($HOME, '~')
	if ($IsWindows) {
		$location = $location.Replace('C:', '').Replace('\', '/')
	}

	Write-Host -NoNewLine "[$time] "
	Write-Host -NoNewLine -ForegroundColor Green "$username"
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

	# TODO: any variables/functions declared inside will be scoped to this function instead of globally
	# maybe use `$script = [ScriptBlock]::Create((Get-Clipboard))` and then modify its AST -
	#   $script.Ast.FindAll({ $args[0] -is [System.Management.Automation.Language.VariableExpressionAst] }, $true)
	#   https://powershell.org/forums/topic/variables-losing-value-in-a-scriptblock-when-passed-to-a-function/
	# or maybe use `Get-Variable -Scope Local` and `Get-ChildItem function:`, and diff them before and after, and copy the results to the global scope
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

function dockersetup {
	$machineName = 'docker'
	docker-machine start "$machineName"
	docker-machine env "$machineName" --shell powershell | Invoke-Expression
}

function dockerssh {
	$machineName = 'docker'
	docker-machine ssh "$machineName"
}

# disable legacy `bash` command in favor of `wsl`,
# because it opens `bash` regardless of the default shell configured
function bash {
	"No, run ``wsl``"
}

# TODO: use https://github.com/mikebattista/PowerShell-WSL-Interop#usage
