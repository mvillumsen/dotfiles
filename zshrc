#
# Executes commands at the start of an interactive session.
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

export GPG_TTY="$(tty)"

# Colorized ls output on macOS (BSD ls)
export CLICOLOR=1


# Aliases
alias ls='ls -G'
alias k='kubectl'
alias kg='kubectl get'
alias kgpo='kubectl get pod'
alias kdpo='kubectl describe pods'
alias kgdep='kubectl get deployment'
alias kddep='kubectl describe deployment'
alias kgsvc='kubectl get service'
alias kdsvc='kubectl describe service'
alias kging='kubectl get ingress'
alias kding='kubectl describe ingress'
alias kge='kubectl get events --sort-by=.metadata.creationTimestamp'
alias klo='kubectl logs'
alias kx="kubectl config use-context"
alias python=/usr/bin/python3
alias tf=terraform

# Completion system
autoload -Uz compinit
compinit

# zsh-autosuggestions
if [[ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [[ -f "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# zsh-syntax-highlighting should be sourced near the end of .zshrc.
if [[ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [[ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

