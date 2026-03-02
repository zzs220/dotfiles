### Enable prompt substitution
setopt prompt_subst

### Load colors (replaces OMZ colors.zsh)
autoload -Uz colors && colors

### Root vs user color
if [[ $UID -eq 0 ]]; then
  NCOLOR="red"
else
  NCOLOR="green"
fi

GIT_COLOR="yellow"

### Native git prompt function (replacement for git_prompt_info)
git_prompt_info() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch dirty
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    dirty=" %F{red}✗%f"
  else
    dirty=" %F{green}✔%f"
  fi

  echo "%F{$GIT_COLOR}(${branch})%f${dirty}"
}

### Left prompt
PROMPT='%F{blue}%n@%m%f: %F{$NCOLOR}%2~ ≫ %f'

### Right prompt
RPROMPT='$(git_prompt_info)'

### LS Colors
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"
