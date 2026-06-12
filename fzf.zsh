# Setup fzf
# ---------
if [[ -d "/opt/homebrew/opt/fzf/bin" && ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
elif [[ -d "/usr/local/opt/fzf/bin" && ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
  [[ -f "/opt/homebrew/opt/fzf/shell/completion.zsh" ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
  [[ -f "/usr/local/opt/fzf/shell/completion.zsh" ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

# Key bindings
# ------------
[[ -f "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]] && source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
[[ -f "/usr/local/opt/fzf/shell/key-bindings.zsh" ]] && source "/usr/local/opt/fzf/shell/key-bindings.zsh"
