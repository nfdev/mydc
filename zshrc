##### MYDC Completion fo ZSH #####

export PATH=${PATH}:~/.mydc/bin

autoload -U compinit
compinit -u

zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

_mydc() {
  _arguments \
    '(- 1)-h[help]:help': \
    '(- 1)-r[remove mydc]:remove mydc:->mydc' \
    '(- 1): :->options'

  case "$state" in
    options)
      _values '' '-r' '-h' `ls ~/.mydc/home`
      ;;
    mydc)
      _values '' `ls ~/.mydc/home`
      ;;
  esac
}

compdef _mydc mydc
#####
