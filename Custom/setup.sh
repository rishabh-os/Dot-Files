#!/bin/bash

# ? Don't assume this is run from the $HOME directory
cd $HOME
# ? Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# ? Install OhMyPosh
curl -s https://ohmyposh.dev/install.sh | bash -s
# ? This will overwrite any existing .zshrc file
curl --output ~/.zshrc "https://raw.githubusercontent.com/rishabh-os/Dot-Files/refs/heads/main/dot_zshrc"

# ? Install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate

# ? Install atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
# * It installs by default to ~/.atuin
mv ~/.atuin/bin/atuin ~/.local/bin/atuin
mv ~/.atuin/bin/atuin-update ~/.local/bin/atuin-update
rm -rf ~/.atuin

# ? Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# ? Install eza manually
wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
chmod +x eza
mv eza $HOME/.local/bin/eza

# ? Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
chezmoi init https://github.com/rishabh-os/Dot-Files.git
chezmoi apply