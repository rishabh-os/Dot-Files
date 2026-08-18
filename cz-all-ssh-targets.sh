#!/bin/bash

[ "$1" = "-n" ] && DRY_RUN=1

# ? Exclude some hosts: git forges, NAS, jumphosts
# ? Also leonardo because it gets stuck
HOSTS=$(rg -oP '^Host \K\S+' ~/.ssh/config | rg -v '[*?]|git|nas|jump|leonardo')
SETUP_CMD=$(rg --no-filename -A1 '^```bash' ~/.local/share/chezmoi/README.md | rg -v '```bash' | tail -n1)

for host in $HOSTS; do
  user=$(ssh -G "$host" 2>/dev/null | rg -oP '^user \K\S+')
  # ? Exclude any machines where I am not the user
  [[ ! $user =~ ^(rishabh|rwanjari)$ ]] && continue

  # ? Smaller connection timeout
  # ? Make zsh interactive + use aliases
  cmd=(ssh "$host" -o ConnectTimeout=5 -t "export PATH=\"\$HOME/.local/bin:\$PATH\"; zsh -ic '$SETUP_CMD'")

  if [ "$DRY_RUN" ]; then
    echo "${cmd[*]}"
  else
    echo "Bootstrapping $host..."
    "${cmd[@]}" || echo "Failed: $host"
  fi
done
