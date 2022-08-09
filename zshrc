#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export GREP_COLOR='1;33'
unsetopt CORRECT

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/mvil/.sdkman"
[[ -s "/Users/mvil/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mvil/.sdkman/bin/sdkman-init.sh"

autoload -U +X bashcompinit && bashcompinit

complete -o nospace -C /usr/local/Cellar/terraform/0.12.26/bin/terraform terraform
alias tf=terraform

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

# Cleanup squashed branches
function ggsquashed() {
  refs=$(git for-each-ref refs/heads/ "--format=%(refname:short)")

  echo "$refs" |
  while read -r branch
  do
    mergeBase=$(git merge-base HEAD $branch)

    branchTree=$(git rev-parse "$branch^{tree}")

    head=$(git commit-tree $branchTree -p $mergeBase -m _)

    cherry=$(git cherry HEAD $head)

    if [[ $cherry == "-"* ]]
    then
      git branch -D $branch
    fi
  done
}

# Cleanup merged branches and squashed branches
alias gg='git pull --all --prune --ff-only && git branch --merged | grep -v -E "^\* " | xargs -I_ git branch -d _ && ggsquashed'


# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

export PATH="${PATH}:${HOME}/.krew/bin"
