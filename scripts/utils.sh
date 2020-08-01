#!/usr/bin/env sh

# exit script on error
set -e

symlink() {
	if [ -e "$2" ]
	then
		if [ "$(realpath "$1")" = "$(realpath "$2")" ]
		then
			echo "Symlink {$2 --> $1} exists"
		else
			echo "Tried to create a dotfile link ($2) but a different dotfile already exists"
			exit 1
		fi
	else
		ln -s "$1" "$2"
		echo "Symlinked {$2 --> $1}"
	fi
}
