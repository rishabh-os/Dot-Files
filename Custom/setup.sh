#!/bin/bash

# ? This path isn't part of $PATH by default
export PATH=$PATH:$HOME/.local/bin
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

# ? Install zellij
curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest \
| grep "zellij-x86_64-unknown-linux-musl.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
tar -xvf zellij*.tar.gz
mv ./zellij $HOME/.local/bin/zellij


# ? Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# ? Install eza manually
wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
chmod +x eza
mv eza $HOME/.local/bin/eza

# ? Install gdu
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
chmod +x gdu_linux_amd64
mv gdu_linux_amd64 $HOME/.local/bin/gdu

# ? Install neovim
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz | tar xz
mv nvim-linux-x86_64 $HOME/.local/bin/nvim-linx-x86_64
ln -s $HOME/.local/bin/nvim-linx-x86_64/bin/nvim $HOME/.local/bin/nvim

# ? Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
chezmoi init https://github.com/rishabh-os/Dot-Files.git
chezmoi apply
