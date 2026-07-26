This is my collection of dot files.

#### Setup

> [!NOTE]
> This script only works completely for `x86_64` machines. I haven't gotten around to implementing an architecture agnostic version yet.

This script is mostly so that I can use the same tools I use on my personal computer on other servers/clusters/machines/SSH targets. The fact that it also clones everything else I configured is just a happy little accident :) (and also perhaps completely unnecessary).

To setup everything, just run:

```bash
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply rishabh-os/Dot-Files --force
```

This installs chezmoi, which setups up my dotfiles and then runs `run_onchange_install-tools.sh`, which is responsible for actually installing all the tools (as the name implies).

It still requires zsh to be installed separately, because I'd rather that be done with the system package manager (write a nice message to a sudoer near you). You're free to build it from source if they are being a meanie (avg Linux sys admin).

Finally, to change your default shell, run

```bash
chsh -s $(which zsh)
```

#### Updating

To update, just run

```bash
cz update --force
```
Alternatively, run it without `--force` for more manual control.

As always, please read the script before executing it blindly.

xoxo


#### Automated Install

`cz-all-ssh-targets.sh` installs the dotfiles on all SSH targets that haven't been filtered out, see the script for more details. More of a convenience script for me to automatically update my config on all machines.