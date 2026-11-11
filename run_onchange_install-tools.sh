#!/bin/bash

export PATH=$PATH:$HOME/.local/bin
cd "$HOME" || exit

# ? Install OhMyZsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ? Install OhMyPosh
if ! command -v oh-my-posh &>/dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
# ? Install zsh plugins
for plugin in \
  "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting.git" \
  "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions" \
  "zsh-history-substring-search|https://github.com/zsh-users/zsh-history-substring-search" \
  "ohmyzsh-full-autoupdate|https://github.com/Pilaton/OhMyZsh-full-autoupdate.git" \
  "fzf-tab|https://github.com/Aloxaf/fzf-tab"; do
  name="${plugin%%|*}"
  url="${plugin##*|}"
  if [ ! -d "$ZSH_CUSTOM/plugins/$name" ]; then
    git clone "$url" "$ZSH_CUSTOM/plugins/$name"
  fi
done

# ? Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# ? Install gah
bash -c "$(curl -fsSL https://raw.githubusercontent.com/get-gah/gah/refs/heads/master/tools/install.sh)"

# ? Install everything else with gah
gah install atuinsh/atuin --unattended --unattended-select-index=2
gah install zellij-org/zellij --unattended --unattended-select-index=2
gah install eza-community/eza --unattended
gah install dundee/gdu --unattended
gah install sxyazi/yazi --unattended --unattended-select-index=2
gah install BurntSushi/ripgrep --unattended
gah install sharkdp/bat --unattended --unattended-select-index=2
gah install sharkdp/fd --unattended
gah install junegunn/fzf --unattended
gah install carapace-sh/carapace-bin --unattended
gah install noborus/ov --unattended
gah install anomalyco/opencode --unattended --unattended-select-index=4
gah install lazygit --unattended
gah install lazydocker --unattended
gah install duf --unattended
gah install aristocratos/btop --unattended

# ? Setup atuin
if ! command -v atuin &>/dev/null; then
  # * Don't modify the .bashrc file
  chmod u-w .bashrc
  atuin setup --no-agent-history --no-threads --no-up-arrow --yes
  chmod u+w .bashrc
fi

# ? Install neovim manually
# ? gah doens't copy the linked libraries that are needed
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz | tar xz
rsync -a --delete nvim-linux-x86_64 "$HOME/.local/bin" && rm -rf nvim-linux-x86_64
ln -fs "$HOME/.local/bin/nvim-linux-x86_64/bin/nvim" "$HOME/.local/bin/nvim"
