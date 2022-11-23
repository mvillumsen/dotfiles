# Executes commands at the start of an interactive session.

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export GREP_COLOR='1;33'
unsetopt CORRECT

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit

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

# Cleanup merged branches and squashed branches
alias gg='git pull --all --prune --ff-only && git branch --merged | grep -v -E "^\* " | xargs -I_ git branch -d _ && ggsquashed'

# Set Python alias
alias python=/usr/bin/python3

alias dgradlew='docker run --rm -it --workdir=/data -v $(pwd):/data adoptopenjdk/openjdk12:jdk-12.0.2_10-debian ./gradlew'

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


eval "$(/opt/homebrew/bin/brew shellenv)"

source <(kubectl completion zsh)
source /opt/homebrew/opt/spaceship/spaceship.zsh
export PATH=$PATH:$HOME/bin
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export GPG_TTY=$(tty)
export GOPATH=$HOME/workspace/go
