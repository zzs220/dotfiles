#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "$HOME/.config/shell/env"

source "$HOME/.config/shell/aliases"

# Only execute if shell is interactive and is bash
if [ -n "$PS1" ] && [ -n "$BASH_VERSION" ]; then
    export PS1='\[\e[34;1m\]\u@\h\[\e[0m\]:\[\e[97m\]\W\[\e[0m\]\$ '
fi
