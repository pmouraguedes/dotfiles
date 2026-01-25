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
" Sensible defaults for Vim (no keymaps, just better defaults)
Plug 'tpope/vim-unimpaired'
" [b ]b  Previous/next buffer
" [q ]q  Previous/next quickfix item
" [l ]l  Previous/next location list item
" [<Space> ]<Space>  Add blank lines above/below
" [e ]e  Exchange line with above/below
Plug 'machakann/vim-highlightedyank'
" Visual feedback when yanking (no keymaps, automatic)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" :Files  Find files in current directory
" :Buffers  List open buffers
" :Rg  Search text with ripgrep
" :Lines  Search lines in open buffers
" :BLines  Search lines in current buffer
Plug 'pmouraguedes/neodarcula.nvim'
" Plug 'jasonccox/vim-wayland-clipboard'

" Text objects and motions
Plug 'tpope/vim-surround'
" cs"'  Change surrounding " to '
" ds"  Delete surrounding "
" ysiw"  Add " around word
" S"  Surround selection with " (visual mode)
Plug 'justinmk/vim-sneak'
" Type s and two chars to start sneaking forward
" Type S and two chars to start sneaking backward
" Type ; or , to proceed with sneaking
Plug 'vim-scripts/ReplaceWithRegister'
" griw  Replace word with register contents
" grip  Replace paragraph with register contents
" gr{motion}  Replace {motion} text with register
Plug 'vim-scripts/argtextobj.vim'
" ia  Inside argument
" aa  Around argument (includes comma)
Plug 'dbakker/vim-paragraph-motion'
" {  Jump to previous blank line
" }  Jump to next blank line
Plug 'michaeljsmith/vim-indent-object'
" <count>ai  An Indentation level and line above
" <count>ii  Inner Indentation level (no line above)
" <count>aI  An Indentation level and lines above/below
" <count>iI  Inner Indentation level (no lines above/below)
Plug 'kana/vim-textobj-user'
" Required dependency for custom text objects (no keymaps)
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
" gcc  Toggle comment for current line
" gc{motion}  Toggle comment for motion
" gcap  Toggle comment for paragraph
" Plug 'easymotion/vim-easymotion'
" <Leader><Leader>w  Jump to word start
" <Leader><Leader>b  Jump to word backward
" <Leader><Leader>f{char}  Find {char} forward
" <Leader><Leader>s{char}  Search {char} bidirectional
Plug 'jeetsukumaran/vim-buffergator'
" <Leader>b  Open buffer catalog
" <Leader>t  Open buffer catalog in new tab

" Git integration
Plug 'tpope/vim-fugitive'
" :Git or :G  Run any git command
" dv  view diff
" cc Create a commit.
" P push
" :Git blame or :Gblame  Show git blame
" :Git diff or :Gdiff  Show git diff in split
" :Gwrite  Stage current file (git add)
" :Gread  Checkout current file (git checkout)
" :Gcommit  Commit staged changes
" :Gpush  Push to remote
Plug 'airblade/vim-gitgutter'
" [c ]c  Jump to previous/next hunk (change)
" <Leader>hp  Preview hunk diff
" <Leader>hs  Stage hunk
" <Leader>hu  Undo hunk
" :GitGutterToggle  Toggle git gutter signs

" Marks and bookmarks
Plug 'kshenoy/vim-signature'
" mx  Toggle mark 'x' (a-zA-Z)
" dmx  Delete mark 'x'
" m,  Place next available mark
" m.  If no mark on line, place next available mark
" m-  Delete all marks on current line
" m<Space>  Delete all marks in buffer
" ]` [`  Jump to next/previous mark
" ]' ['  Jump to start of next/previous marked line
" m/  Show all marks in location list

call plug#end()

" ==============================================================================
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

set numberwidth=4

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
autocmd FileType c,cpp setlocal omnifunc=ccomplete#Complete

set complete=.,w,b,u,t,i
set completeopt=menuone,longest,preview
"set completeopt=menuone,longest

" Usually want longest first, then menu
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
execute "set <M-h>=\eh"
nnoremap <M-h> :tabprevious<CR>
execute "set <M-l>=\el"
nnoremap <M-l> :tabNext<CR>

" Quickfix list
function! ToggleQuickfix()
    let l:qf_open = len(filter(getwininfo(), 'v:val.quickfix')) > 0
    if l:qf_open
        cclose
    else
        copen
    endif
endfunction
nnoremap <leader>xq :call ToggleQuickfix()<CR>

" FZF mappings
nnoremap <leader><Space> :Files<CR>
nnoremap <leader>, :Buffers<CR>
nnoremap <leader>sg :Rg<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>/ :BLines<CR>
nnoremap <leader>h :History<CR>

" Command typo corrections
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q

" ==============================================================================
" PLUGIN SETTINGS
" ==============================================================================
" Highlighted yank duration
let g:highlightedyank_highlight_duration = 250

" buffergator
let g:buffergator_sort_regime = "mru"
let g:buffergator_show_full_buffer_name = 0
let g:buffergator_show_full_directory_path = 0

" gitgutter
let g:gitgutter_sign_column_always = 1    " always show sign column (like many do in Neovim)
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_signs = 1                 " default anyway
let g:gitgutter_sign_added    = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed  = '-'

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
