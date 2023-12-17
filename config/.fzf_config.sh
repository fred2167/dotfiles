

bindkey "ç" fzf-cd-widget
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind 'tab:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}