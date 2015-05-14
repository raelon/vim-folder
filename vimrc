" Make it uncompatible with Vi becuase this is Vim goddamnit
set nocompatible
set t_Co=256

" Activate Pathogen
call pathogen#infect()

" Reset Leader
let mapleader=','

" Fix backspace key for Linux
:set backspace=indent,eol,start

" Remap : to ; save infinite key strokes
nnoremap ; :

" Text formatting
if has("syntax")
	syntax on
endif

if has("autocmd")
	filetype plugin indent on
endif

" Tab formatting
set showmatch
set number
" Size of hard tabstop
set tabstop=4
" Size on an "indent"
set shiftwidth=4
" A combiination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4
" make "tab"  insert indents instead of tabs at the beginning of a line
set smarttab
" always uses spaces instead of tab characters
set expandtab

" Folding
noremap <space> za
set foldmethod=indent
set foldlevel=99

" Map window split movements
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Apperance
set background=dark
syntax enable
colorscheme hybrid
" (Optional) Set column color
"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Addons go below Here
" --------------------

" NERDTree
map <leader>nt :NERDTree<CR>
autocmd vimenter * if !argc() | NERDTree | endif

" Jedi Vim
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-c>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"

" Syncr
" Copy ~/.vim/bundle/vim-syncr/.syncrconf to your root repo
" Uncomment the following command to sync on writes
autocmd BufWritePost * :Suplfil

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
