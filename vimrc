" Plugin Settings -----------------------------------------------------------|
set nocompatible                                      " make uncompatible with vi because this is vim goddamnit
filetype off                                          " required by vundle
" filetype plugin indent on                           " required by vundle
set rtp+=~/.vim/bundle/Vundle.vim/                    " add vundle to run time path
call vundle#rc()                                      " required by vundle

Plugin 'gmarik/Vundle.vim'                            " let vundle manage vundle; required
Plugin 'kien/ctrlp.vim'                               " ctrlp
Plugin 'tpope/vim-fugitive'                           " fugitive
Plugin 'scrooloose/nerdtree'                          " nerdtree
Plugin 'scrooloose/syntastic'                         " syntastic
" Plugin 'jacob-ogre/vim-syncr'                       " syncr
" Plugin 'mschwager/vim-syncr'                        " less anoying syncr
Plugin 'tpope/vim-surround'                           " surround
Plugin 'w0ng/vim-hybrid'                              " vim-hybrid
Plugin 'kchmck/vim-coffee-script'                     " vim-coffee-script
Plugin 'digitaltoad/vim-jade'                         " vim-jade
Plugin 'https://github.com/fatih/vim-go'              " vim-go
Plugin 'sgodbold/vim-potion'
Plugin 'xolox/vim-misc'                               " vim-misc -- dependency for easytags
Plugin 'xolox/vim-easytags'                           " easytags -- automates tag generation

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
set background=dark                                   " enable for dark terminals [=light for light terminals]
set ruler                                             " adds cursor position
set t_Co=256                                          " set color scheme to 256 bit colors
set title                                             " show file in titlebar
syntax enable                                         " use syntax highlighting
colorscheme hybrid                                    " custom color scheme
set relativenumber                                    " enable relative line numbers
set number                                            " hybrid mode so current line shows absolute line number
augroup plugins
  " autocmd BufWritePost * :Suplfil                   " automatic syncr upload on writes
  autocmd vimenter * if !argc() | NERDTree | endif    " enter NERDTree directory if no file specified
augroup END

" Editor Settings -----------------------------------------------------------|
set undofile                                          " save undos after closing a file
set undodir=~/.vim/vimundo                            " save them here
set showmatch                                         " show matching bracket
set cursorline                                        " hightights current line
set number                                            " show line numbers
set scrolloff=5                                       " keep N lines between cursor and screen edge
set ignorecase                                        " case insensitive searching
set smartcase                                         " case sensitive if uppercase is used
set hlsearch                                          " highlight search results
set incsearch                                         " search incrementally
set mouse=v                                           " use mouse in visual mode
set mousehide                                         " hide mouse when typing
set tabstop=2                                         " number of spaces tabs count for
set shiftwidth=2                                      " spaces for auto indents
set expandtab                                         " tabs = spaces
set smarttab                                          " smart tab handling for indenting
set smartindent
set foldmethod=indent                                 " fold the same indent level
set foldlevel=99                                      " fold all the way
set statusline+=%#warningmsg#                         " syntastic recommended
set statusline+=%{SyntasticStatuslineFlag()}          " syntastic recommended        
set statusline+=%*                                    " syntastic recommended
let g:syntastic_always_populate_loc_list = 1          " syntastic recommended
let g:syntastic_auto_loc_list = 1                     " syntastic recommended
let g:syntastic_check_on_open = 1                     " syntastic recommended
let g:syntastic_check_on_wq = 0                       " syntastic recommended
let g:syntastic_cpp_compiler = 'g++'                  " syntastic c++11 support
let g:syntastic_cpp_compiler_options = ' -std=c++14'  " syntastic c++11 support

" uncomment for syntastic debug mode. Run :mes to view log
" let g:syntastic_debug = 1

function MyTabLine()
  let line = 'Tabs:'
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let line .= '%' . i . 'T'
    let line .= (i == tabpagenr() ? '%1*' : '%2*')
    let line .= (' ' . i . ') %*')
    let line .= (i == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let file = bufname(buflist[winnr - 1])
    let file = fnamemodify(file, ':p:t')
    if file == ''
      let file = '[No Name]'
    endif
    let line .= file
    let i = i + 1
  endwhile
  let line .= '%T%#TabLineFill#%='
  let line .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return line
endfunction
set tabline=%!MyTabLine()
hi TabLine ctermfg=White ctermbg=Black cterm=underline
hi TabLineSel ctermfg=Red ctermbg=Black cterm=underline
hi TabLineFill ctermfg=Black ctermbg=White

" Keyboard Mappings ---------------------------------------------------------|

" change leader to ',' instead of '\'
let mapleader=','

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" set <Leader>p to toggle paste mode
:set pastetoggle=<Leader>p

" Remap ':' to ';' save infinite key strokes
nnoremap ; :

" Map za to space for opening and closing folds
noremap <space> za

" Map jk / kj to escape insert mode
inoremap jk <esc>
inoremap kj <esc>
" DONT ESCAPE!!!!
" inoremap <esc> <nop>

" Map <leader>ev to edit vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Map <leader>sv to source vimrc (refresh the settings)
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Map <leader>c for easy line commenting
augroup commenting
    :autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
    :autocmd FileType python     nnoremap <buffer> <localleader>c I# <esc>
augroup END

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

:map <F1> 1gt
:map <F2> 2gt
:map <F3> 3gt
:map <F4> 4gt
:map <F5> 5gt
:map <F6> 6gt
:map <F7> 7gt
:map <F8> 8gt
:map <F9> 9gt

" abbreviations -------------------------------------------------------------|
" filetype specifics --------------------------------------------------------|
autocmd FileType c setlocal tabstop=4
autocmd FileType c setlocal shiftwidth=4
autocmd FileType cpp setlocal tabstop=4
autocmd Filetype cpp setlocal shiftwidth=4
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType go setlocal tabstop=8
autocmd FileType go setlocal shiftwidth=8
