#!/usr/bin/env bash

# Install script that will copy all config files in this repo to the desired
# location in $HOME.

set -eu

declare -a dotfiles

read -p "This script will overwrite your current dotfiles. Are you sure? (Y/n) " res
res=${res,,}
if [[ "$res" != "y" ]] && [[ -n $res ]]; then
    exit 1
fi

dotfiles+=(".bashrc")
dotfiles+=(".bash_profile")
dotfiles+=(".config/nvim/init.vim")

cd "$(dirname -- "${BASH_SOURCE[0]}")"

for file in ${dotfiles[@]}; do
    echo $file
    mkdir -p "$(dirname $HOME/$file)"
    cp "$file" "$HOME/$file"
done

