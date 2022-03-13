# add directories to PATH
# TODO: get PATH directories somehow
#set --export PATH ... $PATH

# aliases for `ls`
alias l='ls -A --group-directories-first'
alias ll='ls -lAh --group-directories-first'
alias lll='ls -lA --group-directories-first'

# make file operations verbose
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -v'
alias rmdir='rmdir -v'

# delete the default Ctrl+R keybinding which tries to run fzf
bind --erase \cr

# for x server programs
set --export DISPLAY :0

# wasmtime env-vars
set -gx WASMTIME_HOME "$HOME/.wasmtime"
set -gx PATH "$WASMTIME_HOME/bin" $PATH
