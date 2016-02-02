"####################################################################
" .vimrc
"####################################################################

set nocompatible " vi compatibility off
scriptencoding utf-8

"" filetype plugin and syntax
filetype off
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
set nosmartindent
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

set number

let mapleader = ","

" stay in visual after indent
vnoremap < <gv
vnoremap > >gv

" remove search hl
nnoremap <silent><C-c> :nohl<CR>

" toggle conversion of buffers to tabs
let notabs = 1
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" switch buffers
nnoremap <silent><Tab> :bn<Cr>
nnoremap <silent><S-Tab> :bp<Cr>

nnoremap <silent><C-C> :nohl<CR>

" save with sudo
cmap w!! w !sudo tee %

" syntax highlighting and formatting for markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.md set colorcolumn=120
autocmd BufNewFile,BufReadPost *.md set tw=120
autocmd BufNewFile,BufReadPost *.md set formatoptions+=t

autocmd BufNewFile,BufReadPost Dockerfile set filetype=dockerfile

au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
au  BufNewFile,BufRead *.handlebars,*.hbs set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim

"" Vundle

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

Bundle 'myusuf3/numbers.vim'

" Bundle 'tpope/vim-fugitive'

" Bundle 'kien/ctrlp.vim'

Bundle 'scrooloose/nerdtree'
nnoremap <silent><C-n> :NERDTreeToggle<Cr>
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeQuitOnOpen=1

Bundle 'tomtom/tcomment_vim'

Bundle 'vim-scripts/taglist.vim'
noremap <silent><leader>t :TlistToggle<Cr>
noremap <silent><C-T> :TlistToggle<Cr>
let Tlist_Use_Right_Window=1
let Tlist_GainFocus_On_ToggleOpen = 1

Bundle 'saltstack/salt-vim'
au BufRead,BufNewFile *.sls set filetype=sls

Bundle 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

Bundle 'bling/vim-bufferline'

Bundle 'davidhalter/jedi-vim'
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures = "0"
autocmd FileType python setlocal completeopt-=preview

Bundle 'ivyl/vim-bling'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'ervandew/supertab'
" Bundle 'rstacruz/sparkup'
" Bundle 'scrooloose/syntastic'
" let g:syntastic_python_flake8_args = "--ignore=E501,W0611,W0401"

" Bundle 'vim-scripts/indentpython.vim'
Bundle 'klen/python-mode'
let g:pymode_folding = 0
let g:pymode_quickfix_minheight = 1
let g:pymode_lint_on_fly = 1
let g:pymode_lint_ignore = "W0401,"
let g:pymode_rope_autoimport_import_after_complete = 1
let g:pymode_doc = 0
let g:pymode_motion = 0
let g:pymode_rope_completion = 0
let g:pymode_lint_cwindow = 0
let g:pymode_options_max_line_length = 120
" let g:pymode_lint_checkers = ['pylint', 'pep8', 'mccabe']
let g:pymode_virtualenv = 1
" set completeopt=menu

set background=dark
Bundle 'trevorrjohn/vim-obsidian'
colorscheme obsidian

Plugin 'othree/html5.vim'
