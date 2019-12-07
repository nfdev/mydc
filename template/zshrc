. /etc/zsh_command_not_found

export HISTFILE=${MYENV}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
. /etc/zsh_command_not_found

function codels (){
  clear
  grep -nrIe $1 ./
}
