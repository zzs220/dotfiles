#!/bin/bash
set -e

cd "$(dirname "$0")"

git stash push
stow --adopt -t "$HOME/.config" config
stow --adopt -t "$HOME" home
git restore .
git stash pop
