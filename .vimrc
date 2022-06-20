set nocompatible

" Setup tabs to match 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2

" Change tabs for python
autocmd FileType python set tabstop=4 | set shiftwidth=4

" Autoindent with newline
set autoindent
set cindent
set cinkeys-=0#
set indentkeys-=0#

" Change autoident for python
autocmd FileType python setlocal foldmethod=indent smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Change trailing spaces and blank lines into bullets and tabs into triangles
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" Show intermediate commands
set showcmd

" Show line numbers
set number
set relativenumber

" Show lines that exceed 80 characters
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Visual mode highlighting.
highlight CursorLine cterm=NONE ctermbg=darkred ctermfg=white

" Turn mouse on.
" set mouse=a
set ttymouse=xterm2

" Disable visual bell to get rid of random Unicode characters showing up
" when using vim in screen.
set noeb vb t_vb=
au GUIEnter * set vb t_vb=

" Load tags.
set tags=./tags;,tags;

" Plugin management
 call plug#begin()
  Plug 'altercation/vim-colors-solarized'
  Plug 'JuliaEditorSupport/julia-vim'
  Plug 'google/vim-maktaba'
  Plug 'google/vim-codefmt'
  Plug 'google/vim-glaive'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'rust-lang/rust.vim'
  Plug 'udalov/kotlin-vim'
call plug#end()

" Solarized background
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
" Resert colorscheme so that solarized changes don't stay in terminal.
au VimLeave * colorscheme desert

" Map "U" to redraw syntax highlighting due to screwups with folds.
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

set wildmenu
set magic

" Autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

" Buggy
let g:lsp_signature_help_enabled=0

" Netrw settings
" Prevents issues with move commands
let g:netrw_keepdir=0
" Open in tree list view
"let g:netrw_liststyle=3

" Clear registers from register list
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

call glaive#Install()
Glaive codefmt plugin[mappings]
Glaive codefmt yapf_executable=yapf3

noremap <Leader>f :FormatLines<cr>

function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

nnoremap <Leader>q :call ToggleQuickFix()<cr>
