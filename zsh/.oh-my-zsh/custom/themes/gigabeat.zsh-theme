_fishy_collapsed_wd() {
  local i pwd
  pwd=("${(s:/:)PWD/#$HOME/~}")
  if (( $#pwd > 1 )); then
    for i in {1..$(($#pwd-1))}; do
      if [[ "$pwd[$i]" = .* ]]; then
        pwd[$i]="${${pwd[$i]}[1,2]}"
      else
        pwd[$i]="${${pwd[$i]}[1]}"
      fi
    done
  fi
  echo "${(j:/:)pwd}"
}

local user_color='cyan'; [ $UID -eq 0 ] && user_color='red'
local ssh='false'; [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && host_color='true'


PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )"
if [[ $host_color == "true" ]]; then
  PROMPT+="%{$fg[yellow]%}%n@%m "
else
  PROMPT+="%{$reset_color%}%{$fg[white]%}%n "
fi
PROMPT+='%{$fg_bold[$user_color]%}$(_fishy_collapsed_wd)%{$reset_color%} '


RPROMPT='$(git_prompt_info)'



ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
