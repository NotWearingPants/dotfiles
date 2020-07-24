# Git config & ignore

## Config

Turns off auto-crlf, and adds a bunch of aliases.

It also includes the file at `~/.gitconfig-user` if it exists.
It should contain the user name & email config (and can contain any other machine-specific config).

## Ignore

All filenames beginning with a tilde (`~`) will be ignored by git. e.g. `~TODO.txt`

This way you can place files related to a project but still personal inside that project's repo folder, without adding it to that repo's `.gitignore` for everyone else to see.
