alias ls="eza --color=auto --icons=auto"
alias ll="eza --color=auto --icons=auto -lah"
alias home-build="nix run home-manager/master -- switch --flake ~/dotfiles/nixos#henrik -b backup"
alias cd..="cd .."
eval "$(zoxide init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
eval "$(direnv hook zsh)"
