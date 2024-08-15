#
# Executes commands at the start of an interactive session.
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"

export GPG_TTY=$(tty)


# Aliases
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

