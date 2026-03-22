#!/bin/bash
dispatch() {
    local script="$1"
    local ui_env="${UI_ENV:-default}"
    local script_dir="$(dirname "${BASH_SOURCE[1]}")"
    local script_path="$script_dir/../$ui_env/$script.sh"
    if [[ ! -f "$script_path" ]]; then
        script_path="$script_dir/../default/$script.sh"
    fi
    exec "$script_path"
}
