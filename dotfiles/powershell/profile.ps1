# TODO: this also outputs in non-login shells, make it stop
# "Welcome"

New-Alias which Get-Command

# save the last result to $_
function Out-Default {
	# NOTE: $input is some sort of an enumerator, so we have to pipe it to get the result
	$input | Tee-Object -Variable result | Microsoft.PowerShell.Core\Out-Default

	# save the result into the $_ variable, but only if it's not an error
	if ($result -isNot [System.Management.Automation.ErrorRecord]) {
		$global:_ = $result
	}
}

function prevtime {
	$lastCommand = Get-History -Count 1
	$time = $lastCommand.EndExecutionTime - $lastCommand.StartExecutionTime
	'{0:mm\:ss\.fff}' -f $time
}

function publicip {
	((Invoke-WebRequest https://api.ipify.org/?format=json).content | ConvertFrom-Json).IP
}
