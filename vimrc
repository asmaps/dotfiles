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
set textwidth=79

"" search
set smartcase
set hlsearch
set incsearch
set showmatch

"####################################################################
" visual style {{{
"####################################################################
"" colorscheme
colorscheme desert
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
autocmd InsertEnter * :setlocal nu
autocmd InsertLeave * :setlocal rnu
"" }}}

"####################################################################
" general auto commands {{{
"####################################################################
" autoremove trailing whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" salt syntax highlighting
au BufRead,BufNewFile *.sls set filetype=sls
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
" switch vim splits with the same keys as tmux panes. {{{
" Credit to https://github.com/aaronjensen
"####################################################################
if exists('$TMUX')
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
        let previous_winnr = winnr()
        execute "wincmd " . a:wincmd
        if previous_winnr == winnr()
          " The sleep and & gives time to get back to vim so tmux's focus tracking
          " can kick in and send us our ^[[O
          execute "silent !sh -c 'sleep 0.01; tmux select-pane -" . a:tmuxdir . "' &"
          redraw!
        endif
    endfunction
    let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
    let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
    let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
    nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
    nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
    nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
    nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
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
"" }}}
