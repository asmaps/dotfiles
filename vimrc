"####################################################################
" .vimrc
"####################################################################

set nocompatible " vi compatibility off
scriptencoding utf-8

"" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"" filetype plugin and syntax
syntax on
filetype indent plugin on

"" system
set enc=utf-8
set shell=/bin/zsh
set spelllang=de
set backspace=indent,eol,start

"" single settings
set hidden " change buffers without saving
set mousehide " no mouse
set wildmenu " menu when tab completing commands
set nomodeline " ignore modelines
set nostartofline " don't move the coursor to the beginning of the line
set foldmethod=marker " fold by marker
set scrolloff=11 " minimum lines to the screens end
set autochdir " always be in the right directory
set pastetoggle=<F12> " toggle paste

"" persistent undo and backup
set history=1000
set undofile
set undodir=~/.backup/
set backup
set backupdir=~/.backup/

"" tabs and stuff
set smartindent
set shiftwidth=4
set softtabstop=4
set expandtab " use spaces
set textwidth=0
set wrapmargin=0

"" search
set smartcase
set hlsearch
set incsearch
set showmatch

"####################################################################
" visual style {{{
"####################################################################
"" colorscheme
"colorscheme wombat256mod " set after the bundles at the end of this file!
set background=dark
set t_Co=256 " force more colors

"" highlight the current line and column
set cul
hi CursorLine cterm=NONE ctermbg=234
set cuc
hi CursorColumn cterm=NONE ctermbg=234

"" coloring of linenumbers
hi CursorLineNr cterm=bold ctermfg=red
hi LineNr ctermfg=blue

"" highlight same words, taken from https://github.com/adimit
hi flicker cterm=bold ctermbg=234
au CursorMoved <buffer> exe 'match flicker /\V\<'.escape(expand('<cword>'), '/').'\>/'

"" statusbar
set cmdheight=2
set laststatus=2
set showcmd

"" linenumbers
set relativenumber
set ruler
set nu
set rnu
autocmd InsertEnter * :setlocal nu | setlocal nornu
autocmd InsertLeave * :setlocal rnu
"" }}}

"####################################################################
" general auto commands {{{
"####################################################################
" autoremove trailing whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" salt syntax highlighting
au BufRead,BufNewFile *.sls set filetype=sls

" arduino syntax highlightning
au BufRead,BufNewFile *.ino set filetype=c
"" }}}

"####################################################################
" keymaps {{{
"####################################################################

let mapleader = ","

" jump to visual lines
nnoremap j gj
nnoremap k gk

" stay in visual after indent
vnoremap < <gv
vnoremap > >gv

" change Y from yy to y$
map Y y$

" remove search hl
nnoremap <silent><C-C> :nohl<CR>

" NERDtree
nnoremap <silent><leader>f :NERDTreeToggle<Cr>

" taglist
nnoremap <silent><leader>t :TlistToggle<Cr>

" toggle conversion of buffers to tabs
let notabs = 1
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" switch buffers
nnoremap <silent><Tab> :bn<Cr>
nnoremap <silent><S-Tab> :bp<Cr>

" save with sudo
cmap w!! w !sudo tee %
"" }}}

"####################################################################
" autoinstall vundle {{{
" Credit to: https://github.com/erikzaadi
"####################################################################

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
"" }}}

"####################################################################
" bundles and their options {{{
"####################################################################
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/taglist.vim'
let Tlist_Use_Right_Window=1
let Tlist_GainFocus_On_ToggleOpen = 1
Bundle 'saltstack/salt-vim'
Bundle 'vim-scripts/wombat256.vim'
colorscheme wombat256mod " needs to be after the bundle
Bundle 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'filename', 'fugitive', 'modified' ] ]
      \ },
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?"ᓯ ".fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }
"" }}}
