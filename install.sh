#!/usr/bin/env bash

# Install script that will copy all config files in this repo to the desired location in $HOME.

set -eu

read -p "This script will overwrite your current dotfiles. Are you sure? [Y/n] " res
res=${res,,}
if [[ "$res" != "y" ]] && [[ -n $res ]]; then
    exit 1
fi

cd "$(dirname -- "${BASH_SOURCE[0]}")"

for file in $(find -type f -not -path './.git/*' -a -not -path './install.sh'); do
    echo $file
    mkdir -p "$(dirname $HOME/$file)"
    cp "$file" "$HOME/$file"
done
