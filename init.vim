set lazyredraw
set ttyfast
set synmaxcol=200
set clipboard=unnamedplus
set number
set relativenumber
set mouse=a
set hidden
set scrolloff=8
set signcolumn=yes
set updatetime=300
set encoding=utf-8
set nobackup
set nowritebackup
set shortmess+=c
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set ignorecase
set smartcase
set incsearch
set hlsearch
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.o,*.obj,*.exe,*.dll,*.so,*.dylib
set wildignore+=*.pyc,*.pyo,*.class
set wildignore+=.git,.svn,.hg
set wildignore+=*.swp,*.swo,*~
set path+=**
set completeopt=menu,menuone,noselect
set splitbelow
set splitright
set cursorline
set colorcolumn=80
set list
set listchars=tab:→\ ,trail:·,nbsp:␣,eol:¬
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000
let mapleader = " "
syntax on
filetype plugin indent on
nnoremap <F5> :!if not exist output mkdir output && g++ -Wall -Wextra -g3 % -o output/%:t:r.exe<CR>
nnoremap <F6> :!output/%:t:r.exe<CR>
nnoremap <F9> :!clang-format -i %<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>ba :bufdo bdelete<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w!<CR>
nnoremap <C-f> /\<C-r><C-w><CR>
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <leader>r "hy:%s/<C-r>h//g<Left><Left>
nnoremap <C-a> ggVG
vnoremap <C-c> y
vnoremap <C-v> p
vnoremap <C-x> d
nnoremap q :q<CR>
nnoremap q! :q!<CR>
nnoremap Q <Nop>
nnoremap Q :q<CR>
nnoremap Q! :q!<CR>
nnoremap <leader>n :set number! relativenumber!<CR>
nnoremap <leader>h :set hlsearch!<CR>
nnoremap <leader>l :set list!<CR>
nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>d :put<CR>
nnoremap <leader>D :put!<CR>
nnoremap <leader>p :put<CR>
nnoremap <leader>P :put!<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>X :x!<CR>
vnoremap < <gv
vnoremap > >gv
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
augroup vimrc
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufRead,BufNewFile *.md setlocal wrap
    autocmd FileType c,cpp setlocal cindent
    autocmd FileType python setlocal shiftwidth=4 tabstop=4
    autocmd FileType javascript,typescript setlocal shiftwidth=2 tabstop=2
augroup END
set laststatus=2
set statusline=%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P
command! -bang W w<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
