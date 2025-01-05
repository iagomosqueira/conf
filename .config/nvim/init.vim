
" --- INI

" leader
let mapleader="\<Space>"
let maplocalleader="\<Space>"

" --- plug.vim

" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

call plug#begin()

" Basic
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" obsidian & markdown
Plug 'nvim-lua/plenary.nvim'
Plug 'epwalsh/obsidian.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" dependencies
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" vsnip
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" R
Plug 'R-nvim/cmp-r'
Plug 'R-nvim/R.nvim'

" Design
Plug 'jalvesaq/southernlights'
Plug 'folke/tokyonight.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/goyo.vim'

" Make
Plug 'neomake/neomake'

call plug#end()

" LOAD plugins conf
lua require("plugins")

" --- MAPPINGS

"move between windows
noremap <C-Up> <C-W>W
noremap <C-Down> <C-W>w

" save
nnoremap ww :w<CR>
nnoremap qq :q<CR>
nnoremap wq :wq<CR>

" move between windows
noremap <C-Up> <C-W>W
noremap <C-Down> <C-W>w

" R.nvim
"nmap <Enter> <Plug>RDSendLine
"nmap <Space> <Plug>RDSendLine
"nmap <C-Enter> <Plug>RESendMBlock
nmap <LocalLeader>r <Plug>RStart
"vmap <Enter> <Plug>RDSendSelection


" --- DISPLAY

set termguicolors
"colorscheme southernlights
colorscheme iago

" Mark line 80
set colorcolumn=96

" keep cursor 4 lines from edge
set scrolloff=4

" system clipboard
set clipboard+=unnamedplus

" disable node provider
let g:loaded_node_provider = 0

" foldtext
set foldtext=foldtext()

"foldmethod
set foldmethod=marker
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Add a left margin
set foldcolumn=2

" show status line
set laststatus=2

" set lines to wrap at nearest space to EOL
set wrap		
set linebreak

" title w/ path + filename
set title titlestring=%-25.55F\ %r%m titlelen=70

" --- STATUS line

" show mode in status bar
set showmode

" airline
function! CondensedPath() abort
  if expand(':h') == '/'
    return '/' . expand('%:t')
  else
    return pathshorten(expand('%:h')) . '/' . expand('%:t')
  endif
endfunction

let g:airline_section_c = airline#section#create(['%{CondensedPath()}'])

" --- MOVEMENT

" allow backspacing over everything in insert mode
set bs=start,indent,eol


" --- BEHAVIOUR

" keep no backup file
set nobackup
set writebackup
set noswapfile

" set autochdir
autocmd BufEnter * silent! lcd %:p:h

" SEARCH options
set ignorecase
set infercase
set smartcase
set hlsearch
set incsearch

" Esc to cancel search highlighting
nnoremap <Esc> :noh<CR><Esc>

" tab options
set tabstop=2 
set softtabstop=0
set expandtab
set shiftwidth=2 
set smarttab

" --- KEYMAPS

" F7 for Copy & Paste to & from system
" Copy
vmap <F7> "+ygv"zy`>
" Paste
nmap <F7> "zgP
" Paste after normal cursor
nmap <S-F7> "zgp
imap <F7> <C-r><C-o>z
" Paste over visual selection)
vmap <C-F7> "zp`]
cmap <F7> <C-r><C-o>z

"SET F1 to Esc
map <F1> <Esc>
imap <F1> <Esc>
