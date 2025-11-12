-- ================================
-- Configuración de Neovim cross-platform
-- ================================

-- Detectar sistema operativo
local sysname = vim.loop.os_uname().sysname
local is_windows = sysname == "Windows_NT"
local is_linux = sysname == "Linux"

-- ================================
-- Gestor de plugins (lazy.nvim)
-- ================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "morhetz/gruvbox" },
  { "sainnhe/gruvbox-material" },
  { "joshdick/onedark.vim" },
  { "neoclide/coc.nvim", branch = "release" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "jiangmiao/auto-pairs" },

  {
    "sphamba/smear-cursor.nvim",
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = true,
      stiffness = 0.8,
      trailing_stiffness = 0.6,
      stiffness_insert_mode = 0.7,
      trailing_stiffness_insert_mode = 0.7,
      damping = 0.95,
      damping_insert_mode = 0.95,
      distance_stop_animating = 0.5,
    },
    config = function(_, opts)
      local ok, smear = pcall(require, "smear_cursor")
      if ok then smear.setup(opts) end
    end,
  },

  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {
      buflisted = false,
      number = false,
      relativenumber = false,
      signcolumn = "auto",
      winfixheight = true,
      wrap = false,
      use_default_opts = true,
      constrain_cursor = true,
      highlight = { treesitter = true, lsp = true, load_buffers = false },
      follow = { enabled = false },
      type_icons = { E = "󰅚 ", W = "󰀪 ", I = " ", N = " ", H = " " },
      borders = {
        vert = "┃", strong_header = "━", strong_cross = "╋",
        strong_end = "┫", soft_header = "╌", soft_cross = "╂",
        soft_end = "┨",
      },
      trim_leading_whitespace = "common",
      max_filename_width = function()
        return math.floor(math.min(95, vim.o.columns / 2))
      end,
      header_length = function(_, start_col)
        return vim.o.columns - start_col
      end,
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "onedark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    },
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },
  { "numToStr/Comment.nvim", opts = {} },
})

-- ================================
-- Apariencia
-- ================================
vim.cmd("syntax on")
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.showmatch = true
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- Colores diferentes según sistema
if is_windows then
  vim.cmd("colorscheme gruvbox-material")
else
  vim.cmd("colorscheme onedark")
end

-- ================================
-- Sangría
-- ================================
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- ================================
-- Autocompletado coc.nvim
-- ================================
vim.opt.completeopt = {"menuone", "noinsert", "noselect"}
vim.opt.shortmess:append "c"
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false

-- Confirmar autocompletado con Enter o Tab
vim.api.nvim_set_keymap("i", "<CR>", 'coc#pum#visible() ? coc#pum#confirm() : "<CR>"', {silent=true, expr=true})
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? coc#_select_confirm() : "<Tab>"', {silent=true, expr=true})
vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', {expr=true, silent=true})

-- ================================
-- Autoindentación
-- ================================
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true

-- ================================
-- Atajos
-- ================================
-- Deshacer
vim.keymap.set('i', '<C-z>', '<C-o>u')
vim.keymap.set('n', '<C-z>', 'u')

-- Portapapeles
vim.keymap.set('v', '<C-c>', '"+y')
vim.keymap.set('n', '<C-v>', '"+p')
vim.keymap.set('i', '<C-v>', '<C-r>+')

-- Ctrl+Tab: siguiente buffer
vim.keymap.set('n', '<C-Tab>', ':bnext<CR>', { noremap = true, silent = true })
-- Ctrl+Shift+Tab: buffer anterior
vim.keymap.set('n', '<C-S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

-- Selección
vim.opt.selection = "exclusive"
vim.opt.selectmode = "mouse,key"

-- Shift + Flechas para moverse en visual/insert/normal
local directions = {Left='h', Right='l', Up='k', Down='j'}
for k, v in pairs(directions) do
  vim.keymap.set('i', '<S-'..k..'>', '<Esc>v'..v)
  vim.keymap.set('n', '<S-'..k..'>', 'v'..v)
end

-- Ponemos las direcciones de nvim una más a la izquierda (h j k l) -> (j k l ñ)
vim.keymap.set('n', 'j', 'h')
vim.keymap.set('n', 'k', 'j')
vim.keymap.set('n', 'l', 'k')
vim.keymap.set('n', 'ñ', 'l')



-- ================================
-- Configuración de Treesitter
-- ================================
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c" },
  highlight = {
      enable = true,
      disable = { "c" },
  },
}

