# vim:ft=zsh ts=2 sw=2 sts=2
#
() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  BRANCH_CHAR=$'\ue0a0'
  SEPARATOR='→'
}

function git_branch {
  is_git_branch=$(git rev-parse --is-inside-work-tree 2> /dev/null); 
  if [ ! -z $is_git_branch ]; then
    echo " %{$fg[red]%}${BRANCH_CHAR} $(git rev-parse --abbrev-ref HEAD)"
  else
    echo ""
  fi
}

function status {
  local symbols
  symbols=()
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡ "
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙ "

  [[ -n "$symbols" ]] && echo "$symbols"
}

PS1='$(status)%{$fg[yellow]%}${USERNAME}:%{$fg[green]%}%~$(git_branch)%{$fg[green]%} ${SEPARATOR} %{$fg[white]%}'
