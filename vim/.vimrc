" ==============================================================================
" VIM-PLUG SETUP
" ==============================================================================
" Install vim-plug if not already installed:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Then run :PlugInstall

call plug#begin()

" Core plugins
Plug 'tpope/vim-sensible'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'doums/darcula'
Plug 'jasonccox/vim-wayland-clipboard'

" Text objects and motions
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
" Type s and two chars to start sneaking forward
" Type S and two chars to start sneaking backward
" Type ; or , to proceed with sneaking
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-scripts/argtextobj.vim'
Plug 'dbakker/vim-paragraph-motion'
Plug 'michaeljsmith/vim-indent-object'
" <count>ai  An Indentation level and line above
" <count>ii  Inner Indentation level (no line above)
" <count>aI  An Indentation level and lines above/below
" <count>iI  Inner Indentation level (no lines above/below)
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
filetype plugin indent on     " Enable plugins and indentation

" ==============================================================================
" UI & VISUAL SETTINGS
" ==============================================================================
syntax on                     " Enable syntax highlighting
set termguicolors             " Enable true color support
colorscheme pablo             " Color scheme

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

" Cursor shape in different modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"  " Insert mode - line
let &t_SR = "\<Esc>]50;CursorShape=2\x7"  " Replace mode - underline
let &t_EI = "\<Esc>]50;CursorShape=0\x7"  " Normal mode - block

" Whitespace characters
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.

" ==============================================================================
" SEARCH SETTINGS
" ==============================================================================
set incsearch                 " Incremental search
set hlsearch                  " Highlight search results
set ignorecase                " Case insensitive search
set smartcase                 " Case sensitive when uppercase present

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

" ==============================================================================
" PLUGIN SETTINGS
" ==============================================================================
" Highlighted yank duration
let g:highlightedyank_highlight_duration = 250
