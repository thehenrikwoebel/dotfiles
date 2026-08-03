alias ls="eza --color=auto --icons"
alias ll="eza --color=auto --icons -lah"
alias cd..="cd .."
eval "$(zoxide init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
