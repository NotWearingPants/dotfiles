#!/usr/bin/env sh

ROOT=$(dirname -- "$0")

# install programs using apt
which apt > /dev/null && $ROOT/../apt/install.sh

# setup programs
$ROOT/../docker/install.sh
$ROOT/../git/install.sh
$ROOT/../ssh/install.sh
$ROOT/../mongodb/install.sh
$ROOT/../editorconfig/install.sh
$ROOT/../readline/install.sh
$ROOT/../gdb/install.sh
#$ROOT/../hyper/install.sh

# setup programming languages
$ROOT/../python/install.sh
$ROOT/../npm/install.sh

# setup terminal multiplexers
$ROOT/../tmux/install.sh
$ROOT/../screen/install.sh

# setup text editors
$ROOT/../vscode/install.sh
$ROOT/../sublime/install.sh
$ROOT/../vim/install.sh
$ROOT/../nano/install.sh

# setup shells
$ROOT/../fish/install.sh
$ROOT/../bash/install.sh
$ROOT/../zsh/install.sh
$ROOT/../powershell/install.sh
