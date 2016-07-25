" Plugins
" =============

"Setup Vundle For Package Management

"Vundle begins here, turn off filetype temporarily
filetype off
"Add vundle and any other packages not installed through vundle to our lookup
"path
set rtp+=~/.vim/bundle/Vundle.vim,/usr/local/lib/node_modules/typescript-tools
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" # Themes
Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/base16-vim'

" # Enhanced Syntax
Plugin 'plasticboy/vim-markdown'
Plugin 'elzr/vim-json'

" # Extra Syntax

" Functionality

" ### Indispensable

" ctrlp is file fuzzy search
Plugin 'kien/ctrlp.vim'
" Ag.vim uses ack to search within files
Plugin 'rking/ag.vim'
"Airline provides a stylish appearance for the styleline
Plugin 'bling/vim-airline'
" Syntastic provides syntax info
"Plugin 'scrooloose/syntastic'
" Show git info in the gutter, sad that it and syntastic fight for space though
"Plugin 'airblade/vim-gitgutter'
" For use with things version control tools other than git
Plugin 'mhinz/vim-signify'
" Integrate with tmux
Plugin 'christoomey/vim-tmux-navigator'
" Provides Sublime-Text like smart completion of braces, parens and such
Plugin 'Raimondi/delimitMate'
" Great helpful autocompletion (requires a separate compile step)
Plugin 'Valloric/YouCompleteMe'
" Easy commenting in Vim
Plugin 'tpope/vim-commentary'
" Adds more text objects
Plugin 'wellle/targets.vim'

" ### Use sometimes

"Nerdtree provides a file explorer, which is sometimes useful. Mostly ctrlp handles file finding though
Plugin 'scrooloose/nerdtree'
" fugitive provides git bindings in Vim.  Don't use too much, but useful for blame
Plugin 'tpope/vim-fugitive'
" Surround is useful for adding surrounding tags to elements (especially html and quotes)
Plugin 'tpope/vim-surround'
" Allows vim-surround to be used with . command
Plugin 'tpope/vim-repeat'
"Adds convenience stuff for writers
Plugin 'reedes/vim-pencil'
"Provide snippets functionality in Vim
Plugin 'SirVer/ultisnips'
"UltiSnip snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
"Standardize whitespace
Plugin 'editorconfig/editorconfig-vim'

"End Vundle
call vundle#end()
"Vundle ended so reenable filetypes
filetype plugin indent on
"Pull in matchit.vim, which is already bundled with Vim
runtime! macros/matchit.vim


" Appearance
" ==========

"Syntax highlighting should be in 256 colors
syntax on
syntax enable
set t_Co=256

" Use base-16 for the color scheme, different themes in GUI and terminal
if has('gui_running')
    colorscheme solarized
    set background=light
    set guifont=Source\ Code\ Pro\ For\ Powerline
else
    let base16colorspace=256  " Access colors present in 256 colorspace
    colorscheme solarized
    set background=dark
endif

" Sanity Config
" ==============================================

set nocompatible                " Use vim rather than vi settings
set encoding=utf-8              " standard encoding
set relativenumber              " prefer absolute #
set number                      " Its nice to see line numbers
set backspace=indent,eol,start  " Allow backspace in insert mode
set autoread                    " Reload files changed outside vim
set hidden                      " Buffers can exist in the background
set history=1000                " Store lots of :cmdline history (its not 1990)
set shellpipe=2>/dev/null>      "  Don't dump distracting text to terminal during searches!
set re=1                        " Use a non-broken regex engine for syntax highlighting

" General Config
" ==============

let mapleader = "\<Space>"      " I just use the default Leader
set showcmd                     " Show incomplete cmds down the bottom
set gcr=a:blinkon0              " Disable cursor blink
set laststatus=2                " Always show status line
set splitright                  " Opens vertical split right of current window
set splitbelow                  " Opens horizontal split below current window
set shortmess=filnxtToOI        " see :help shortmess
"set t_ti= t_te=                " Use a different terminal to run external commands
set shell=bash                  " Set shell to bash (fish and VIM don't play well together)

" Mouse
" ======

" Send more characters for redraws
set ttyfast
" Enable mouse use in all modes
set mouse=a
" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2


" Search Settings
" ===============

set incsearch        " Find the next match as we type the search
set hlsearch         " Highlight searches by default
set viminfo='100,f1  " Save up to 100 marks, enable capital marks

" Turn Off Swap Files
" ===================

set noswapfile
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Persistent Undo
" ===============
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" Keep undo history across sessions, by storing in file
" Only works in MacVim (gui) mode
if has('gui_running')
  set undodir=~/.vim/backups
  set undofile
endif

" Indentation and Display
" =======================

" We want to replace tabs with spaces and have 4 space width indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

set list listchars=tab:\ \ ,trail:·   " Display tabs and trailing spaces visually
set nowrap                            " Don't wrap lines

" Change curser with insert mode
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" Folds
" =====
set foldmethod=indent   " Fold based on indent
set foldnestmax=3       " Deepest fold is 3 levels
set nofoldenable        " Don't fold by default
" nnoremap <space> za
" vnoremap <space> zf

" Completion
" ==========

"set wildmode=list:longest
set wildmode=longest,list,full
set wildmenu                    " Enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~     " Stuff to ignore when tab completing
set wildignore+=*vim/backups*

" Scrolling
" =========

" Start scrolling when we're getting close to margins
set scrolloff=20
set sidescrolloff=20
set sidescroll=1

" vimdiff Specific controls
" =========================
if &diff
    " Remap change navigation
    nmap <c-u> [c
    nmap <c-d> ]c
endif

" General remaps
" =============
" Fast quit everything
nmap ZA :qa<CR>

" Custom commands
" ===============

"Let K be the opposite of J
map K i<Enter><Esc>
"\ rr => refresh vimrc
map <leader>rr :source ~/.vimrc<CR>
" Have j and k move down visual likes when pressing, and physical lines with
" count.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Make a commend to enable wrapping
command! -nargs=* Wrap set wrap linebreak nolist
" \ s Make a comand to start a search and replace under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

" Trim trailing whitespace
function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

"PJ
"
function! PJOpen()
  enew
  read ! pj
endfunction

function! OpenFile()
  let bufferno = bufnr('%')
  exe 'edit' . getline('.')
  exe 'bw!' . bufferno
endfunction

command! PJOpen call PJOpen()

command! OpenFile call OpenFile()

" Plugin Options
" ==============
" Ag.vim options
let g:ag_working_pathMode="r"

" CTRL+P options

set wildignore+=*/wcui/dist/*
let g:ctrlp_user_command = 'ag %s -i --nocolor --ignore .git  --ignore .svn  --ignore .hg  --ignore .DS_Store  --ignore "static"  --ignore "**/*.pyc"  -g ""'

" Airline options
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set noshowmode " Let airline handle the mode display

" Timeout faster insert mode
set timeoutlen=1000 ttimeoutlen=0

"Syntastic Options
" let g:syntastic_check_on_open = 1
" map <Leader>e :Errors<cr>
" let g:syntastic_error_symbol = "✗"
" let g:syntastic_warning_symbol = "⚠"
" let g:syntastic_javascript_checkers = ["eslint"]

"NerdTree Options
map <c-t> :NERDTreeToggle<CR>
let NERDTreeHijackNetrw=1 "Put Nerdtree into a window

"YouCompleteMe options
let g:ycm_min_num_of_chars_for_completion=3
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

"jinja config
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja

"Utisnips config

"" Trigger configuration. Can't use tab with YouCompleteMe
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction


au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"

" Edit snippets in a split
let g:UltiSnipsEditSplit='vertical'

"Tmux (Doing this again because Neovim thats why)
nnoremap <silent> <ctrl-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <ctrl-l> :TmuxNavigateRight<cr>

"Markdown options
let g:vim_markdown_folding_disabled=1
let g:pencil#wrapModeDefault = 'hard'   " or 'soft'

" Pencil Options
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft'})
  autocmd FileType text call pencil#init({'wrap': 'hard'})
augroup END

nnoremap <silent> <leader>ps :SoftPencil<cr>
nnoremap <silent> <leader>ph :HardPencil<cr>
nnoremap <silent> <leader>pn :NoPencil<cr>
nnoremap <silent> <leader>pt :TogglePencil<cr>

"Treat es6 as js
autocmd BufNewFile,BufRead *.es6   set filetype=javascript

"Typescript
let g:syntastic_typescript_tsc_args ='-t ES5 --module commonjs'

"Tern for es6
"let g:tern#command=['/usr/local/bin/node', '/Users/ben/Code/projects/tern-es6/bin/tern']

" Allow doxygen syntax highlighting
let g:load_doxygen_syntax=1
