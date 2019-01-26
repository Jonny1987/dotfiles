"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Miscellaneous
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

" load plugin file for this filetype when file edited
filetype plugin indent on

" highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" turn off audible and visual error bells
set vb t_vb=

" a buffer becomes hidden when it is abandoned rather than unloaded, meaning
" undo history still accessable
set hidden

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines gap between cursor and edge - when moving vertically using j/k
set so=7

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Nerdtree shortcut
map <C-n> :NERDTreeToggle<CR>

" Fast saving
nmap <leader>w :w!<cr>

" Let's save undo info!
if !isdirectory($HOME."/.vimundo")
        call mkdir($HOME."/.vimundo", "", 0700)
endif
set undodir=~/.vimundo
set undofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MUST RUN :PlugInstall TO INSTALL PLUGINS

"""" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""" Install plugins
call plug#begin()
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-surround'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
call plug#end()

"""""" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""""" NerdTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Start Nerdree at start
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

"Toggle with ctrl + n
nnoremap <C-n> :NERDTreeToggle<Enter>

" Show hidden
let NERDTreeShowHidden=1

"" Close NERDTree if it is the last open buffer
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
" Close all open buffers on entering a window if the only
"buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            endif
        endif
    endif
endfunction

"""" YAPF
map <C-Y> :call yapf#YAPF()<cr>
imap <C-Y> <c-o>:call yapf#YAPF()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Aliases
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" allow pasting over selected text and deleting rather than cutting
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    colorscheme desert
catch
endtry

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

"" tab size in spaces when editing
set softtabstop=4

" Linebreak on 79 characters
"set lbr
"set tw=79

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                     " Show current line number
set relativenumber             " Show relative line numbers

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=1
execute pathogen#infect()
call pathogen#helptags()
