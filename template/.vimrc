set number
set laststatus=2
set list
set listchars=tab:>-,nbsp:_,trail:_,extends:_,precedes:_,eol:$
set hlsearch

let s:dein_dir = expand('$HOME/.dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

set tabstop=2
set shiftwidth=2
set expandtab

if &compatible
  set nocompatible
endif
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('$HOME/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

let g:PyFlakeOnWrite = 1
let g:PyFlakeChecker = 'pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10
let g:syntastic_python_checkers = ['pyflakes', 'pep8']


filetype plugin indent on
syntax enable

"colorscheme focuspoint
colorscheme industry

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 
