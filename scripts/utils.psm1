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
		Write-Output "Symlink {$linkLocation --> $linkTarget} exists"
	} else {
		New-Item -ItemType SymbolicLink "$linkLocation" -Target "$linkTarget" -ErrorAction Stop | Out-Null
		Write-Output "Symlinked {$linkLocation --> $linkTarget}"
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
		Write-Output "Folder at {$location} exists"
	} else {
		New-Item -ItemType Directory "$location" -ErrorAction Stop | Out-Null
		Write-Output "Created a folder at {$location}"
	}
}

function Load-ListFile {
	param (
		[String]$location
	)

	Select-String -Pattern '^\s*([^#]+?)\s*(?:#|$)' -Path "$location" | ForEach-Object { $_.Matches.Groups[1].Value }
}
