" Plugin Settings -----------------------------------------------------------|
set nocompatible                                    " make uncompatible with vi because this is vim goddamnit
filetype off                                        " required by vundle
filetype plugin indent on                           " required by vundle
set rtp+=~/.vim/bundle/Vundle.vim/                  " add vundle to run time path
call vundle#rc()                                    " required by vundle

Plugin 'gmarik/Vundle.vim'                          " let vundle manage vundle; required
Plugin 'kien/ctrlp.vim'                             " ctrlp
Plugin 'tpope/vim-fugitive'                         " fugitive
Plugin 'scrooloose/nerdtree'                        " nerdtree
Plugin 'scrooloose/syntastic'                       " syntastic
Plugin 'jacob-ogre/vim-syncr'                       " syncr
Plugin 'tpope/vim-surround'                         " surround
Plugin 'w0ng/vim-hybrid'                            " vim-hybrid
Plugin 'kchmck/vim-coffee-script'                   " vim-coffee-script
Plugin 'digitaltoad/vim-jade'                       " vim-jade

call vundle#end()
filetype plugin indent on

" Swap out ag (the silver searcher) for grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Display Settings ----------------------------------------------------------|
set background=dark                                 " enable for dark terminals [=light for light terminals]
set ruler                                           " adds cursor position
set t_Co=256                                        " set color scheme to 256 bit colors
set title                                           " show file in titlebar
syntax enable                                       " use syntax highlighting
colorscheme hybrid                                  " custom color scheme
autocmd vimenter * :set relativenumber              " relative line numbers when file opend
autocmd InsertLeave * :set relativenumber           " relative line numbers in normal mode
autocmd InsertEnter * :set number                   " absolute line numbers in insert mode
autocmd BufWritePost * :Suplfil                     " automatic syncr upload on writes
autocmd vimenter * if !argc() | NERDTree | endif    " enter NERDTree directory if no file specified

" Editor Settings -----------------------------------------------------------|
set undofile                                        " save undos after closing a file
set undodir=~/.vim/vimundo                          " save them here
set showmatch                                       " show matching bracket
set cursorline                                      " hightights current line
set number                                          " show line numbers
set scrolloff=5                                     " keep N lines between cursor and screen edge
set ignorecase                                      " case insensitive searching
set smartcase                                       " case sensitive if uppercase is used
set hlsearch                                        " highlight search results
set incsearch                                       " search incrementally
set mouse=v                                         " use mouse in visual mode
set mousehide                                       " hide mouse when typing
set expandtab                                       " tabs = spaces
set tabstop=4                                       " number of spaces tabs count for
set shiftwidth=4                                    " spaces for auto indents
set smarttab                                        " smart tab handling for indenting
set smartindent
set foldmethod=indent                               " fold the same indent level
set foldlevel=99                                    " fold all the way
set statusline+=%#warningmsg#                       " syntastic recommended
set statusline+=%{SyntasticStatuslineFlag()}        " syntastic recommended        
set statusline+=%*                                  " syntastic recommended
let g:syntastic_always_populate_loc_list = 1        " syntastic recommended
let g:syntastic_auto_loc_list = 1                   " syntastic recommended
let g:syntastic_check_on_open = 1                   " syntastic recommended
let g:syntastic_check_on_wq = 0                     " syntastic recommended

" Keyboard Mappings ---------------------------------------------------------|

" change leader to ',' instead of '\'
let mapleader=','

" set <Leader>p to toggle paste mode
:set pastetoggle=<Leader>p

" Remap ':' to ';' save infinite key strokes
nnoremap ; :

" Map za to space for opening and closing folds
noremap <space> za

" Fix backspace key for linux
:set backspace=indent,eol,start

" Map ctrl+o to open NERDTree directory
:map <C-o>nt :NERDTree<CR>

" Map ctrl+s to toggle syntastic
:map <C-s> :SytasticToggleMode<CR>

" Map ctrl+b to open git blame
:map <C-b> :Gblame<CR>

" Map ctrl+d to open git diff
:map <C-d> :Gdiff<CR>
