#requires -RunAsAdministrator

function New-Symlink {
	param (
		[String]$linkLocation,
		[String]$linkTarget
	)

	$existingItem = Get-Item "$linkLocation" -ErrorAction SilentlyContinue
	if ($existingItem) {
		if (-not ($existingItem.LinkType -eq 'SymbolicLink' -and $existingItem.Target -eq "$linkTarget")) {
			throw "Tried to create a dotfile link ($linkLocation) but a different dotfile already exists"
		}
	} else {
		New-Item -ItemType SymbolicLink "$linkLocation" -Target "$linkTarget" -ErrorAction Stop | Out-Null
	}
}

function New-Folder {
	param (
		[String]$location
	)

	$existingItem = Get-Item "$location" -ErrorAction SilentlyContinue
	if ($existingItem) {
		if (-not ($existingItem.Attributes -band [IO.FileAttributes]::Directory)) {
			throw "Tried to create a directory ($location) but something else already exists there"
		}
	} else {
		New-Item -ItemType Directory "$location" -ErrorAction Stop | Out-Null
	}
}
