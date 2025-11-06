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
curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest \
| grep "zellij-x86_64-unknown-linux-musl.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
tar -xvf zellij*.tar.gz
rm zellij*.tar.gz
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

# ? Install yazi
curl -L https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-musl.zip -o tmp.zip
unzip tmp.zip
rm tmp.zip
mv ./yazi-x86_64-unknown-linux-musl/yazi $HOME/.local/bin/yazi
mv ./yazi-x86_64-unknown-linux-musl/ya $HOME/.local/bin/ya
rm -rf ./yazi*

# ? Install ripgrep
curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest \
| grep "browser_download_url.*x86_64-unknown-linux-musl.tar.gz" \
| grep -v ".sha256" \
| cut -d '"' -f 4 \
| wget -qi -
tar -xvf ripgrep*.tar.gz --wildcards '*/rg' --strip-components=1
rm ripgrep*.tar.gz
mv ./rg $HOME/.local/bin/rg

# ? Install fd
curl -s https://api.github.com/repos/sharkdp/fd/releases/latest \
| grep "browser_download_url.*x86_64-unknown-linux-musl.tar.gz" \
| cut -d '"' -f 4 \
| wget -qi -
tar -xvf fd*.tar.gz --wildcards '*/fd' --strip-components=1
rm fd*.tar.gz
mv ./fd $HOME/.local/bin/fd

# ? Install fzf
curl -s https://api.github.com/repos/junegunn/fzf/releases/latest \
| grep "browser_download_url.*linux_amd64.tar.gz" \
| cut -d '"' -f 4 \
| wget -qi -
tar -xvf fzf*.tar.gz
rm fzf*.tar.gz
mv ./fzf $HOME/.local/bin/fzf

# ? Install ov
curl -s https://api.github.com/repos/noborus/ov/releases/latest \
| grep "browser_download_url.*linux_amd64.zip" \
| cut -d '"' -f 4 \
| wget -qi -
unzip ov*.zip 'ov'
rm ov*.zip
mv ./ov $HOME/.local/bin/ov

# ? Install bat
curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
| grep "browser_download_url.*x86_64-unknown-linux-gnu.tar.gz" \
| cut -d '"' -f 4 \
| wget -qi -
tar -xvf bat*.tar.gz --wildcards '*/bat' --strip-components=1
rm bat*.tar.gz
mv ./bat $HOME/.local/bin/bat

# ? Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
chezmoi init https://github.com/rishabh-os/Dot-Files.git
chezmoi apply
# ? Useful when rerunning the script, not necessary on first run
chezmoi update
