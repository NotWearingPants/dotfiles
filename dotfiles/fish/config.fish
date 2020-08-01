# add directories to PATH
# TODO: get PATH directories somehow
#set --export PATH ... $PATH

# aliases for `ls`
alias l='ls -A --group-directories-first'
alias ll='ls -lAh --group-directories-first'
alias lll='ls -lA --group-directories-first'

# for x server programs
set --export DISPLAY :0

# wasmtime env-vars
set -gx WASMTIME_HOME "$HOME/.wasmtime"
set -gx PATH "$WASMTIME_HOME/bin" $PATH
