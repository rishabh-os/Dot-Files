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
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# ? Install atuin
# * Don't modify the .bashrc
chmod u-w .bashrc
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
chmod u+w .bashrc
# * It installs by default to ~/.atuin
mv ~/.atuin/bin/atuin ~/.local/bin/atuin
mv ~/.atuin/bin/atuin-update ~/.local/bin/atuin-update
rm -rf ~/.atuin

# ? Install zellij
gah install zellij-org/zellij --unattended


# ? Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# ? Install gah
bash -c "$(curl -fsSL https://raw.githubusercontent.com/get-gah/gah/refs/heads/master/tools/install.sh)"

# ? Install eza manually
gah install eza-community/eza --unattended

# ? Install gdu
gah install dundee/gdu --unattended

# ? Install neovim
gah install neovim/neovim --unattended

# ? Install yazi
gah install sxyazi/yazi --unattended

# ? Install ripgrep
gah install BurntSushi/ripgrep --unattended

# ? Install fd
gah install sharkdp/fd --unattended

# ? Install fzf
gah install junegunn/fzf --unattended

# ? Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
chezmoi init https://github.com/rishabh-os/Dot-Files.git
chezmoi apply
# ? Useful when rerunning the script, not necessary on first run
chezmoi update
