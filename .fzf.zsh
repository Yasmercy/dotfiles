# Setup fzf
# ---------
if [[ ! "$PATH" == */home/yasmercy/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/yasmercy/.fzf/bin"
fi

source <(fzf --zsh)
