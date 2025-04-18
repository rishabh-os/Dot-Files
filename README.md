This is my collection of dot files.

#### Setup

This script is mostly so that I can use the same tools I use on my personal computer on other servers/clusters/machines/SSH targets. The fact that it also clones everything else I configured is just a happy little accident :) (and also perhaps completely unnecessary).

To setup everything, just run the setup script, with

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/rishabh-os/Dot-Files/refs/heads/main/Custom/setup.sh)"
```

It still requires neovim and zsh to be installed separately, because I'd rather that be done with the system package manager (write a nice message to a sudoer near you).

Finally, to change your default shell, run

```bash
chsh -s $(which zsh)
```

#### Updating

To update, just run

```bash
cz update
```
And select all-overwrite (by pressing `a` at the prompt).

As always, please read the script before executing it blindly.

xoxo
