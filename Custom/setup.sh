#!/bin/bash

# ? This path isn't part of $PATH by default
export PATH=$PATH:$HOME/.local/bin
# ? Don't assume this is run from the $HOME directory
cd "$HOME" || exit

# ? Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME"/.local/bin
chezmoi init https://github.com/rishabh-os/Dot-Files.git
chezmoi apply --force
# ? Useful when rerunning the script, not necessary on first run
chezmoi update --force
