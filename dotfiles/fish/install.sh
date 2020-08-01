#!/usr/bin/env sh

ROOT=$(realpath "$(dirname "$0")")

. "$ROOT/../../scripts/utils.sh"

# symlink the config file
symlink "$ROOT/config.fish" "$HOME/.config/fish/config.fish"

# symlink all of the function files
for function_file in "$ROOT/functions"/*
do
	symlink "$function_file" "$HOME/.config/fish/functions/$(basename "$function_file")"
done
