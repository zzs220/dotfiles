#!/bin/bash
set -e

cd "$(dirname "$0")"

stow -t "$HOME/.config" config
stow -t "$HOME" home
