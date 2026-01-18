" ==============================================================================
" VIM-PLUG SETUP
" ==============================================================================
" Auto-install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Core plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pmouraguedes/neodarcula.nvim'
" Plug 'jasonccox/vim-wayland-clipboard'

" Text objects and motions
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
" Type s and two chars to start sneaking forward
" Type S and two chars to start sneaking backward
" Type ; or , to proceed with sneaking
Plug 'vim-scripts/ReplaceWithRegister'
" yia
Plug 'vim-scripts/argtextobj.vim'
Plug 'dbakker/vim-paragraph-motion'
Plug 'michaeljsmith/vim-indent-object'
" <count>ai  An Indentation level and line above
" <count>ii  Inner Indentation level (no line above)
" <count>aI  An Indentation level and lines above/below
" <count>iI  Inner Indentation level (no lines above/below)
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
" ae  Entire buffer content
" ie  Entire buffer without leading/trailing empty lines
Plug 'glts/vim-textobj-comment'
" ic  Inside comment block
" ac  Around comment block (including delimiters)
Plug 'kana/vim-textobj-function'
" if  Inside function
" af  Around function (including signature)
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'

call plug#end()

" ==============================================================================
" BASIC SETTINGS
" ==============================================================================
set nocompatible              " Disable vi compatibility
set encoding=utf-8            " UTF-8 encoding
set hidden                    " Allow hidden buffers
set modelines=0               " Security
set noswapfile                " Disable swap files
filetype plugin indent on     " Enable plugins and indentation

" ==============================================================================
" UI & VISUAL SETTINGS
" ==============================================================================
syntax on                     " Enable syntax highlighting
set termguicolors             " Enable true color support
colorscheme neodarcula        " Color scheme

set mouse=a                   " Enable mouse support
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set ruler                     " Show file stats
set laststatus=2              " Status bar
set showmode                  " Show current mode
set showcmd                   " Show command in bottom bar
set visualbell                " Blink cursor on error instead of beeping
set scrolloff=10              " Keep 10 lines visible above/below cursor
set so=5                      " Short option for scrolloff

" Cursor shape in different modes (Kitty terminal / standard DECSCUSR sequences)
let &t_SI = "\e[6 q"  " Insert mode - steady vertical bar
let &t_SR = "\e[4 q"  " Replace mode - steady underline
let &t_EI = "\e[2 q"  " Normal mode - steady block

" Whitespace characters
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.

" ==============================================================================
" SEARCH SETTINGS
" ==============================================================================
set incsearch                 " Incremental search
set hlsearch                  " Highlight search results
set ignorecase                " Case insensitive search
set smartcase                 " Case sensitive when uppercase present

" :grep
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ==============================================================================
" INDENTATION & WHITESPACE
" ==============================================================================
set wrap                      " Wrap lines
set autoindent                " Auto indent
set smartindent               " Smart indent
set tabstop=4                 " 4 spaces for tabs
set softtabstop=4             " 4 spaces for soft tabs
set shiftwidth=4              " 4 spaces for indentation
set expandtab                 " Use spaces instead of tabs

" ==============================================================================
" COMPLETION & WILDMENU
" ==============================================================================
set wildmenu                  " Enable auto completion menu
set wildmode=longest:full,full " Bash-like completion
set path+=**                  " Search down in subfolders
set omnifunc=syntaxcomplete#Complete

" Ignore certain directories and files
set wildignore+=**/venv/**,**/.venv/**
set wildignore+=**/node_modules/**
set wildignore+=**/.git/**
set wildignore+=**/__pycache__/**
set wildignore+=*.pyc,*.pyo
set wildignore+=**/build/**,**/dist/**

" ==============================================================================
" PERFORMANCE
" ==============================================================================
set ttyfast                   " Fast terminal connection
set ttimeout                  " Enable timeout for key codes
set ttimeoutlen=1             " Fast key code timeout

" ==============================================================================
" CLIPBOARD
" ==============================================================================
set clipboard=unnamedplus     " Use system clipboard (Linux)
" set clipboard=unnamed       " Use system clipboard (Mac)

" ==============================================================================
" KEY MAPPINGS
" ==============================================================================
let mapleader=" "             " Map leader to space

" Center screen after scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Navigate between methods and center
nnoremap <C-f> ]mzz
nnoremap <C-b> [mzz

" Quick escape from insert mode
inoremap jj <Esc>

" Tab navigation
nnoremap <M-h> :tabprevious<CR>
nnoremap <M-l> :tabNext<CR>

" ==============================================================================
" PLUGIN SETTINGS
" ==============================================================================
" Highlighted yank duration
let g:highlightedyank_highlight_duration = 250

" ==============================================================================
" CLIPBOARD WORKAROUND (for vim without +clipboard support)
" ==============================================================================
" Auto-copy yanked text to system clipboard using xclip
if executable('xclip')
  augroup ClipboardYank
    autocmd!
    autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | call system('xclip -selection clipboard', @0) | endif
  augroup END
endif
