" ================================
"   Configuración de Neovim para C
" ================================

" --- Plugins ---
call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jiangmiao/auto-pairs'
call plug#end()

lua << EOF2
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c" },
  highlight = {
      enable = true,
      disable = { "c" },
  },
}
EOF2

" --- Apariencia ---
syntax on
set termguicolors
colorscheme onedark
set number
set showmatch
filetype plugin indent on
syntax enable

" --- Sangría ---
set tabstop=4
set shiftwidth=4
set expandtab

" --- Autocompletado (coc.nvim) ---
" Configura opciones de completado
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set updatetime=300
set signcolumn=yes
set hidden
set nobackup
set nowritebackup


" Confirmar autocompletado con Enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


" Opcional: Mapear Tab también para confirmar el completado
inoremap <silent><expr> <Tab> pumvisible() ? coc#_select_confirm() : "\<Tab>"

" --- Autoindentación ---
filetype plugin indent on
set smartindent
set autoindent
set cindent

" --- Atajos ---
inoremap <C-z> <C-o>u
nnoremap <C-z> u
vnoremap <C-c> "+y
nnoremap <C-v> "+p
inoremap <C-v> <C-r>+
inoremap <C-H> <C-W>
inoremap <silent><expr> <C-Space> coc#refresh()

set selection=exclusive
set selectmode=mouse,key

inoremap <S-Left> <Esc>vbh
inoremap <S-Right> <Esc>vl
inoremap <S-Up> <Esc>vk
inoremap <S-Down> <Esc>vj

