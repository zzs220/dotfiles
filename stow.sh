#!/bin/bash
set -e

cd "$(dirname "$0")"

stow --adopt -t "$HOME/.config" config
stow --adopt -t "$HOME" home
git restore .
