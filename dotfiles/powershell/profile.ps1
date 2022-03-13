# TODO: this profile file also runs in non-login shells (`powershell -command`), make it stop

# print the powershell version and username and computer name
& {
	$versionMajor = $PSVersionTable.PSVersion.Major
	$versionMinor = $PSVersionTable.PSVersion.Minor
	$versionBits = if ([Environment]::Is64BitProcess) { 64 } else { 32 }
	# "PowerShell v$versionMajor.$versionMinor $($versionBits)bit | $env:USERNAME@$env:COMPUTERNAME"
}

# TODO: what is the builtin $IsCoreClr and is it the same?
$IsPSCore = $PSVersionTable.PSEdition -eq 'Core' # rather than 'Desktop'
# add the cross-platform variables
if (-not $IsPSCore) {
	$IsWindows = $true
	$IsLinux = $false
	$IsMacOS = $false
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

# fish-like tab completions, showing a navigatable menu of completions
# for more than 100 completion options it will ask y/n and print completions instead of a menu
# NOTE: Ctrl+Alt+? (question mark) will show all keybindings, and Alt+? will show a specific one
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# turn off the bell, i hate it
Set-PSReadlineOption -BellStyle None

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

function pasteq { # paste quiet
	# TODO: any variables/functions declared inside will be scoped to this function instead of globally
	# maybe use `$script = [ScriptBlock]::Create((Get-Clipboard))` and then modify its AST -
	#   $script.Ast.FindAll({ $args[0] -is [System.Management.Automation.Language.VariableExpressionAst] }, $true)
	#   https://powershell.org/forums/topic/variables-losing-value-in-a-scriptblock-when-passed-to-a-function/
	# or maybe use `Get-Variable -Scope Local` and `Get-ChildItem function:`, and diff them before and after, and copy the results to the global scope
	Get-Clipboard | Out-String | Invoke-Expression
}
function paste {
	# NOTE: this must be piped to Out-Host for it to display before running it, otherwise it will display it only after the function ends
	$continuationPrompt = (Get-PSReadLineOption).ContinuationPrompt
	Get-Clipboard | ForEach-Object { "$continuationPrompt$_" } | Out-Host

	pasteq
}

function prevtime {
	$lastCommand = Get-History -Count 1
	'{0:mm\:ss\.fff}' -f $lastCommand.Duration
}

function privateip {
	(Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex (Get-NetConnectionProfile).InterfaceIndex).IPAddress
}
function routerip {
	(Get-NetIPConfiguration -InterfaceIndex (Get-NetConnectionProfile).InterfaceIndex).IPv4DefaultGateway.NextHop
}
function publicip {
	((Invoke-WebRequest https://api.ipify.org/?format=json).content | ConvertFrom-Json).IP
}
if ($IsWindows) {
	function dnsoverhttps {
		param($hostname)
		wsl curl --silent --http2 -H 'accept: application/dns-json' "'https://1.1.1.1/dns-query?name=$hostname'" `| jq -r '.Answer[0].data'
	}
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

# fix priority in PATH problem with java for ffdec
function ffdec {
	~\scoop\apps\oraclejre8\current\bin\java -jar $HOME\scoop\apps\ffdec\current\ffdec.jar
}

# easy shortcut for the pywin32 docs
if ($IsWindows) {
	function pywin32 {
		Start-Process '~/scoop/apps/python/current/Lib/site-packages/PyWin32.chm'
	}
}

# disable legacy `bash` command in favor of `wsl`,
# because it opens `bash` regardless of the default shell configured
function bash {
	'No, run `wsl`'
}

# edit the command history text file
function historyedit {
	code (Get-PSReadLineOption).HistorySavePath
}

# commands to reload the profile
# TODO: this doesn't reload functions that i change
# TODO: `new-alias`/`remove-alias` commands fail
function reloadprofile {
	@(
		$Profile.AllUsersAllHosts,
		$Profile.AllUsersCurrentHost,
		$Profile.CurrentUserAllHosts,
		$Profile.CurrentUserCurrentHost
	) | % {
		if (Test-Path $_) {
			Write-Verbose "Running $_"
			$measure = Measure-Command {
				. $_
			}
			"Took $($measure.TotalSeconds) seconds"
		}
	}
}

# for natural sort
# usage: ls | sort $natural
$natural = { [regex]::Replace($_, '\d+', { $args[0].Value.PadLeft(20) }) }

# delete sl which is aliased to cd, because when writing ls fast you might accidentally go back to the home folder
# TODO: install the equivalent of linux's sl, or alias sl to ls
if ($IsPSCore) {
	Remove-Alias sl -Force
} else {
	# old powershell doesn't support remove-alias
	Remove-Item alias:\sl -Force
}

# TODO: use https://github.com/mikebattista/PowerShell-WSL-Interop#usage
# TODO: https://superuser.com/questions/468782/show-human-readable-file-sizes-in-the-default-powershell-ls-command
# TODO: consider https://github.com/Pscx/Pscx

# fix python unicode output
$env:PYTHONIOENCODING = 'utf-8'


# Windows only: change tab completion to use '/' instead of '\', remove 'C:', and abbreviate home as ~ (linux already abbreviates)
# modified from https://github.com/PowerShell/PowerShell/issues/10509#issuecomment-740220540
if ($IsWindows) {
	$private:globalScopeVariable = $true

	# change the TabExpansion2 function to replace the path separators in tab completions of file and directory paths
	# the default function is defined in https://github.com/PowerShell/PowerShell/blob/403767d7f7b910a6f315505287fe9a72c3960c52/src/System.Management.Automation/engine/InitialSessionState.cs#L4100-L4149
	function TabExpansion2 {
		[CmdletBinding(DefaultParameterSetName = 'ScriptInputSet')]
		Param(
			[Parameter(ParameterSetName = 'ScriptInputSet', Mandatory = $true, Position = 0)]
			[string] $inputScript,

			[Parameter(ParameterSetName = 'ScriptInputSet', Position = 1)]
			[int] $cursorColumn = $inputScript.Length,

			[Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 0)]
			[System.Management.Automation.Language.Ast] $ast,

			[Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 1)]
			[System.Management.Automation.Language.Token[]] $tokens,

			[Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 2)]
			[System.Management.Automation.Language.IScriptPosition] $positionOfCursor,

			[Parameter(ParameterSetName = 'ScriptInputSet', Position = 2)]
			[Parameter(ParameterSetName = 'AstInputSet', Position = 3)]
			[Hashtable] $options = $null
		)

		End {
			$completions = if ($psCmdlet.ParameterSetName -eq 'ScriptInputSet') {
				[System.Management.Automation.CommandCompletion]::CompleteInput($inputScript, $cursorColumn, $options)
			}
			else {
				[System.Management.Automation.CommandCompletion]::CompleteInput($ast, $tokens, $positionOfCursor, $options)
			}

			# tab completion will call us from the global scope, guard against it to not affect anything else
			if (Get-Variable -ErrorAction Ignore -Scope 1 -ValueOnly globalScopeVariable) {
				# fix the separators in file-system path completions
				for ($i = 0; $i -lt $completions.CompletionMatches.Count; $i++) {
					$cm = $completions.CompletionMatches[$i]

					# only modify filesystem paths (file or directory)
					if ($cm.ResultType -notin 'ProviderItem', 'ProviderContainer') { continue }

					# replace the separators, main drive, and abbreviate home
					$text = $cm.CompletionText.Replace($HOME, '~').Replace('C:', '').Replace('\', '/')

					# the text of directory paths lacks a final separator which is added by PSReadLine
					# (https://github.com/PowerShell/PSReadLine/blob/dc38b451bee4bdf07f7200026be02516807faa09/PSReadLine/Completion.cs#L369-L372)
					# so to change it we append it ourselves and change ResultType to always be 'ProviderItem' so it won't append the separator
					# we also need to handle a possibly quoted path. this unfortunately makes PSReadLine not move the cursor back to before the quote to continue typing
					if ($cm.ResultType -eq 'ProviderContainer') {
						$suffix = ''
						if ($text.EndsWith("'") -or $text.EndsWith('"')) {
							$suffix = $text[-1]
							$text = $text.Remove($text.Length - 1)
						}
						if (-not $text.EndsWith('/')) {
							$text += '/'
						}
						$text += $suffix
					}

					# replace the completion with the new one, and set the type to always be a file to prevent PSReadLine from appending a backslash
					$completions.CompletionMatches[$i] = [System.Management.Automation.CompletionResult]::new($text, $cm.ListItemText, 'ProviderItem', $cm.ToolTip)
				}
			}

			# return the potentially modified completions
			$completions
		}
	}
}
