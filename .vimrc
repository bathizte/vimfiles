set nocompatible

" Path2Gen : plugins in .vim/bundle
filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

"""""""""""""""""""""""""""""
" Répertoires, fichiers, 
" swap
"""""""""""""""""""""""""""""
set acd                         " va au fichier en cours d'édition
set autochdir                   " répertoire courant = celui buffer

if has("unix") || has("win32unix")
    set directory=/tmp       " et des  *.swp à part  
elseif has("win32") || has("win64")
    set directory=$TMP       " et des  *.swp à part  
endif

set encoding=utf-8              " encodage par défaut
set autoread                    " rechargement auto des fichiers modifiés 
set hidden                      " Ne crie pas au scandale 'not saved' lors du chgmt de buffer
set nobackup                    " Don't make backups
set title                       " Change term title
set titleold=                   " Restore Old title on exit

filetype on                     " Types de fichiers
filetype plugin on 
 
"""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""
set background&                 " Background color detection
set mouse=n                     " Mouse grabbing only in normal mode
set ruler                       " Cursor position
set nu                          " Line numbering
set showmode                    " Current mode
set showcmd                     " Current command
set wildmenu                    " Autocompletion
set wildmode =list:longest,list:full    " Completion displays everything
set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz    " Ignore some file types
set visualbell                  " No beep
set vb t_vb=                    " Visual bell

set cursorline

set ut=4000                     " 4s
au CursorHoldI * stopinsert     " automatically leave insert mode after 'updatetime' milliseconds of inaction

let mapleader = ","            " leader remapping on , for an azerty kb
let maplocalleader = "œ"       " local leader remapped on '²'
set pastetoggle=<F5>           " Change paste mode via F5
"""""""""""""""""""""""""""""
" Text options
""""""""""""""""""""""""""""
set list
"set foldmethod=syntax
set foldmethod=indent
set listchars=tab:>·,trail:·,eol:¶


" tabs : 4 espaces
set smarttab                    " 'shiftwidth en début de ligns, '(soft) tabstop' ailleurs 
set expandtab                   " espaces au lieu des tabs
set tabstop=4                   " indentations de 4 espaces
set softtabstop=4               " Indente les tabs
set shiftwidth=4                
set nowrap

" Indent 
filetype indent on 
filetype plugin indent on
set preserveindent
set autoindent 
set smartindent
"set cindent " Works more cleverly than the other two and is configurable to different indenting styles.
"set cinoptions = "(1"


" Moving
set whichwrap=<,>,h,l,[,]       " Send the cursor on next / previous line when using moving arrows at EOL
set nostartofline               " Try to stay on the same column when changing line
set scrolloff=3                 " Visible lignes offset
set virtualedit=onemore         " Virtual edit allows to add chars at the EOL

"set backspace=indent,eol,start 

" remappe les moves pour permettre les accents


" désactive les flêches directionnelles
"map <left> <Esc>
"map <Down> <Esc>
"map <Up> <Esc>
"map <Right> <Esc>
"imap <Left> <Esc>
"imap <Down> <Esc>
"imap <Up> <Esc>
"imap <Right> <Esc>
 

syntax on

set ofu=syntaxComplete#Complete
set showmatch 

""""""""""""""""""""""""""""""
" TODO : Neocomplete https://github.com/Shougo/neocomplete.vim
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" recherche
""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set incsearch
set hlsearch
nmap <F6> :set hls!<CR> 
set nohls

" Correcteur orthographique
set spelllang =en,fr
"set spell
set spellsuggest =5

"""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""
" Enable folding
set foldenable
"set nofen
set fdl=0
set foldcolumn=1
set foldmethod=indent

" Diff
set diffopt+=iwhite
 
""""""""""""""""""""""""""""""
" Raccourcis
" map : mode commande
" imap mode insertion
"""""""""""""""""""""""""""""
imap ii <Esc>" i : insertion : ii escape 
map <leader>cd :cd %:p:h<CR>


" Déplace des blocks 
nnoremap <M-j> mz:m+<CR>`z==
nnoremap <M-k> mz:m-2<CR>`z==
inoremap <M-j> <Esc>:m+<CR>==gi
inoremap <M-k> <Esc>:m-2<CR>==gi
vnoremap <M-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

map <C-t> :tabnew<CR>

" Numérotation relative/absolue
"nnoremap <C-L> :call g:ToggleNuMode()<cr>

" write after prompting sudo 
cmap w!! %!sudo tee > /dev/null %
 

"""""""""""""""""""""""""""""
" Plugins & leurs raccourcis
"""""""""""""""""""""""""""""
filetype plugin on 

if !has("gui_running")
    let g:Tb_MapWindowNavVim = 1
    let g:Tb_MapWindowNavArrows = 1
    let g:Tb_MapCTabSwitchBufs = 1
    let g:Tb_ModSelTarget = 1
endif


" Nerdtree par <F2>, Mirror par <F3>
nmap <F2> :NERDTreeToggle<cr>
"let NERDTreeChDirMode = 1
nmap <F3> :NERDTreeMirror<cr> 

" NERDCommenter
let g:NERDSpaceDelims = 1 "1 space after comment char
let g:NERDDefaultAlign = 'left' "column aligned comment chars


"TagList par F4
nmap <F4> :TlistToggle<cr>
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Update = 1
let Tlist_Show_One_File = 1

" Airline 
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_monokai'

" Vicle
let g:vicle_session_name = 'dev'
let g:vicle_session_window = '0'

""""""""""""""""""""""""""""
" chargement des specific
"""""""""""""""""""""""""""
function! LoadSpecific(extension)
    if has("unix") 
        silent! execute 'source ' . $HOME . '/.vim/specific/'. a:extension. '.vim'
    if has("win32")
        silent! execute 'source ' . $HOME . '/.vimfiles/specific/'. a:extension. '.vim'
endfunction

autocmd BufRead * silent! call LoadSpecific('%:e')

" Viki files
let g:vikiNameSuffix=".wiki"
autocmd! BufRead,BufNewFile *.wiki set filetype=viki


" Chargement des replis 
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

iab <expr> lejour strftime("%d/%m/%Y")


" modified monokai (256 color) based on original molokaii
colorscheme monokaii
"colorscheme base16-default-dark
"let base16colorspace=256

"""""""""""""""""""""""""""
" Status Line 
""""""""""""""""""""""""""
set ls=2
if has("statusline")
 set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set modeline        " Modeline override
set modelines=10

source ~/.vim/functions.vim
if filereadable(expand("~/.vimrc.local"))
source ~/.vimrc.local " Include user's local vim config
endif

" Screen-specific workarounds
if match($TERM, "screen")!=-1
     exe "set title titlestring=vim:%f"
     exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
     exe "set ttymouse=xterm2"
     set cursorline!
endif
