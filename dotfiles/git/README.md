# Git config & ignore

## Config

[Git config docs](https://git-scm.com/docs/git-config)
|
[More Git config docs](https://github.com/git/git/blob/master/Documentation/config.txt)

Turns off auto-crlf, and adds a bunch of aliases.

### Users

The config includes the file at `~/.config/git/config-user` if it exists.

It should contain the user name & email config (and can contain any other machine-specific config).

To use multiple identities, you can use:
- [Conditional configuration](https://github.blog/2017-05-10-git-2-13-has-been-released/#conditional-configuration) to switch based on the local repo path
- [this post-checkout hook](https://github.com/DrVanScott/git-clone-init) to switch based on the remote URL
- [this git identities trick](https://davorpa.github.io/git-utils/git-identity-profiles.html) to switch on command

## Ignore

All filenames beginning with a tilde (`~`) will be ignored by git. e.g. `~TODO.txt`

This way you can place files related to a project but still personal inside that project's repo folder, without adding it to that repo's `.gitignore` for everyone else to see.
