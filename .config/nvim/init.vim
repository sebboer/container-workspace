call plug#begin('~/.local/share/nvim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'itchyny/lightline.vim'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'chrisbra/Colorizer'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'lervag/vimtex'
Plug 'mcchrish/nnn.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'cespare/vim-toml'
Plug 'joshdick/onedark.vim'
Plug 'pangloss/vim-javascript'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'ekalinin/Dockerfile.vim'

call plug#end()


" Theme
"colorscheme onedark

let g:lightline = {
	\ 'colorscheme': 'onedark',
	\}

" Config
" syntax on
set tabstop=2
set softtabstop=0
set shiftwidth=2
set number relativenumber
set ignorecase
set showmatch
set autoindent
set splitbelow splitright
set updatetime=500
set signcolumn=yes
set ttimeoutlen=100

" Key Maps
nnoremap <C-n> :NnnPicker %:p:h<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-t> :tabnew<space>

autocmd Filetype rmd,rmarkdown map <F5> :Rarkdown pdf<CR>
autocmd Filetype tex map <F10> :VimtexCompile <CR>
autocmd BufRead,BufNewFile *.rmd set filetype=rmarkdown
map <C-c> "*y
map <C-a> ggVG
map <C-v> "+gP


" --- Airline Settings ---
set laststatus=2
let g:airline_powerline_fonts=1

" --- vimtex Settings ---
let g:vimtex_view_method = 'zathura'

" --- nnn Settings ---
let g:nnn#layout = { 'left': '~40%' } " or right, up, down<Paste>
let g:nnn#action = { '<c-t>': 'tab split'}

" rust.vim settings
let g:rustfmt_autosave = 1

" --- NERDCommenter ---
