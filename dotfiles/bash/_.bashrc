# source the default bashrc that was put aside, before everything else
# TODO: add all stuff from ubuntu's default bashrc to here and remove this include
if [ -f ~/.bashrc_default ]; then
    . ~/.bashrc_default
fi

# detect OS
case "$(uname -s)" in
    Linux)      os=Linux;;
    Darwin)     os=Mac;;
    CYGWIN*)    os=Windows;;
    MINGW*)     os=Windows;;
esac


# greetings
# TODO: set these somehow
#NAME=...
#PHONETIC_NAME=...
#(say -v Karen "Welcome, $PHONETIC_NAME" &)
#toilet -t --font mono9 --metal "$NAME"
#toilet -t --font mono12 --gay "$NAME"
#cowsay -f stegosaurus "Welcome, $NAME"

# unlimited history filesize
HISTSIZE=
HISTFILESIZE=

# cd to directory by just typing its name
#shopt -s autocd

# add directories to PATH
# TODO: get PATH directories somehow
#export PATH=...:$PATH

ps1_tput() { echo "\[$(tput $@)\]"; } # see `man terminfo` for values
DARKRED=$(ps1_tput setaf 1)
DARKWHITE=$(ps1_tput setaf 7)
GREEN=$(ps1_tput setaf 10)
YELLOW=$(ps1_tput setaf 11)
CYAN=$(ps1_tput setaf 14)
BOLD=$(ps1_tput bold)
RESET=$(ps1_tput sgr0)
# TODO: put "..." if \w is over a third of the screen width (tput cols)
PS1="${RESET}[\A] ${GREEN}\u${RESET}:${YELLOW}\w${CYAN}\$(__git_ps1)${RESET}\\$ "
#CURSOR_UP="$(ps1_tput up)"
#CURSOR_RIGHT="$(ps1_tput nd)"
#PS0="#{CURSOR_UP}${CURSOR_RIGHT}${DARKWHITE}hello${RESET}"

# TODO: doesn't work
alias oops=sudo !!

# case insensitive tab completion
bind "set completion-ignore-case on"
# tab once not twice to show completion matches
bind "set show-all-if-ambiguous on"
# turn off the f***ing bell, make it visual
bind "set bell-style visible"

# TODO: make tab copmletion's ls colored

# TODO: bash doesn't have global aliases, only command aliases
alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..

# extra stuff for macOS, make it like zsh and some aliases
if [[ $os == 'Mac' ]]; then
    alias l='ls -lah'
    alias la='ls -lAh'
    alias ll='ls -lh'
    alias ls='ls -G'
    alias lsa='ls -lah'

    PS1="${RESET}[${DARKWHITE}${BOLD}\u${RESET}:${DARKRED}\w${RESET}]\$ "
    alias subl="/Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text"
fi

# make file operations verbose
alias mv='mv -v'
alias cp='cp -v'

# for x server programs
export DISPLAY=:0
