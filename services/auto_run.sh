#!/usr/bin/bash

if ! mkdir ~/.loc.lock; then
        printf "Failed to acquire lock.\n" >&2
            exit 1
            fi
            trap 'rm -rf ~/.loc.lock' EXIT
# rest of script ...
~/.local/bin/command
