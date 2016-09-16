" My vimrc file

if !has('win32')
  set backup                   " make backup file
  set backupdir=~/.vim/backups " where to put backup files
  set directory=~/.vim/swaps   " directory for temp files
endif

set list                     " show whitespace characters
" set listchars=tab:>-,trail:- " show tabs and trailing whitespace

set showcmd                  " show command in bottom bar
set number                   " Enable line numbers
syntax on                    " Set syntax highlighting
set showmatch                " Highlight matching braces

set ignorecase               " Match ignore case
set smartcase                " dont ignore case when searching all caps
set hlsearch                 " Highlight searches
set incsearch                " Highlight as you type

" Manage tabs the way I want
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" When editing a file, always jump to the last known cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

