# ---- Zinit Bootstrap ----
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
# ---- Zinit Bootstrap ----

source "$HOME/.config/shell/env"
source "$HOME/.config/shell/aliases"
alias ls='ls --color=auto -lh'

source "$ZINIT_HOME/zinit.zsh"
ZINIT_DIR="$HOME/.config/zinit"
### History
HISTSIZE=10000
SAVEHIST=10000
setopt vi
setopt appendhistory sharehistory hist_ignore_dups hist_reduce_blanks inc_append_history

### Completion
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
autoload -Uz compinit
compinit -C

### OMZ Plugins
zinit snippet OMZP::git
zinit snippet OMZP::extract
zinit snippet OMZP::sudo
zinit snippet OMZP::colored-man-pages
## fzf
zinit ice wait lucid atinit"source shell/key-bindings.zsh; source shell/completion.zsh"
zinit light junegunn/fzf
## zoxide
eval "$(zoxide init zsh)"
### Theme
source "$ZINIT_DIR/prompt.zsh"

### Enhancements
# zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
