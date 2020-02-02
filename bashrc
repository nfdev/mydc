
##### MYDC Completion fo BASH #####

export PATH=${PATH}:~/.mydc/bin

_mydc() {
  local cur prev cword envs myenvs

  if [ -z "${MYENVS}" ]; then
    myenvs="${HOME}/.mydc/home"
  else
    myenvs=$(echo "${MYENVS}")
  fi

  if [ ! -d "${myenvs}" ]; then
    envs=""
  else
    envs=$(ls "${myenvs}")
  fi
  opts="-r"

  _get_comp_words_by_ref -n : cur prev cword

  if [ "${cword}" -eq 1 ]; then
    COMPREPLY=($(compgen -W "${opts} ${envs}" -- "${cur}"))
  elif [ "${cword}" -eq 2 ]; then
    if [ "${prev}" == "-r" ]; then
      COMPREPLY=($(compgen -W "${envs}" -- "${cur}"))
    else
      COMPREPLY=""
    fi
  fi
}

complete -F _mydc mydc
#####
