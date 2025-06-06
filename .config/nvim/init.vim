
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
Plug 'github/copilot.vim'

" obsidian & markdown
Plug 'nvim-lua/plenary.nvim'
Plug 'obsidian-nvim/obsidian.nvim'
Plug 'jc-doyle/cmp-pandoc-references'
Plug 'quarto-dev/quarto-nvim'
Plug 'jmbuhr/otter.nvim'
Plug 'jc-doyle/cmp-pandoc-references'
Plug 'AntonVanAssche/md-headers.nvim'
Plug 'hedyhli/outline.nvim'
Plug 'epheien/outline-treesitter-provider.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'bullets-vim/bullets.vim'

" dependencies
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/nvim-treesitter-context'
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
Plug 'sainnhe/sonokai'
Plug 'folke/tokyonight.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/goyo.vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'folke/todo-comments.nvim'

" Tools
Plug 'neomake/neomake'
Plug 'tpope/vim-dispatch'
Plug 'cvigilv/esqueleto.nvim'
Plug 'folke/flash.nvim'

call plug#end()

" LOAD plugins conf
lua require("plugins")

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

" SET F1 to Esc
map <F1> <Esc>
imap <F1> <Esc>

" F11 to set spell
autocmd FileType text,markdown,rmarkdown setlocal spell
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>

" save
nnoremap ww :w<CR>
nnoremap qq :q<CR>
nnoremap wq :wq<CR>

" move between windows
noremap <C-Up> <C-W>W
noremap <C-Down> <C-W>w

" move by screen line
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" R.nvim
nmap <LocalLeader>r <Plug>RStart

" md-headers
nnoremap <LocalLeader>h :lua require('md-headers').markdown_headers(false)<CR>

" open terminal
nmap <F8> :!alacritty&<CR><CR>

" --- DISPLAY

set termguicolors

"colorscheme southernlights

"let g:sonokai_style = 'andromeda'
"let g:sonokai_better_performance = 1
"
"colorscheme sonokai
"let g:lightline = {'colorscheme' : 'sonokai'}
"hi Normal guibg=black

colorscheme iago

" Mark line 80
set colorcolumn=96

" keep cursor 4 lines from edge
set scrolloff=4

" system clipboard
set clipboard+=unnamedplus

" set local provider
let g:loaded_node_provider = 0
let g:node_host_prog = '~/.nvm/versions/node/v23.11.0/lib/node_modules'
let g:copilot_node_command = '~/.nvm/versions/node/v23.11.0/bin/node'
let g:copilot_workspace_folders = ["~/Projects/FLR/code"]
let g:copilot_enabled = v:false

" foldtext
set foldtext=foldtext()

"foldmethod
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

" --- PLUGINS

" Neomake
nnoremap <F12> :w\|:Neomake!<CR>

" Rmd maker
let g:neomake_rmarkdown_render_maker = {
  \ 'exe': 'R',
  \ 'args': ['--slave', '--no-restore', '--no-save', '-e rmarkdown::render("%t")'],
  \ 'append_file': 0,
  \ 'errorformat': 
    \ '%W%f:%l:%c: style: %m,' .
    \ '%W%f:%l:%c: warning: %m,' .
    \ '%E%f:%l:%c: error: %m,'
  \ }

let g:neomake_rmarkdown_enabled_makers = ['render']

" SET foldmethod for R
autocmd Filetype r setlocal foldmethod=marker

" [diagnostic signs disappear when entering insert mode #26078](https://github.com/neovim/neovim/issues/26078)
lua vim.diagnostic.config({virtual_text={format=function(d) return "" end}, signs=true})

" markdown preview
function OpenMarkdownPreview (url)
  execute "silent ! firefox --new-window " . a:url
endfunction

let g:mkdp_browserfunc = 'OpenMarkdownPreview'

