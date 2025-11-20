local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath
    })
end


vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({


  -- Temas
  { "morhetz/gruvbox" },
  { "sainnhe/gruvbox-material" },
  { "joshdick/onedark.vim" },

  -- Otros plugins simples
  { "jiangmiao/auto-pairs" },
  { "numToStr/Comment.nvim", opts = {} },
  { "sphamba/smear-cursor.nvim", opts = {} },

  -- FuzzyFinder
  { "nvim-telescope/telescope.nvim", tag = "v0.1.9"},

  -- Cambiar entre ventanas
  { "ThePrimeagen/harpoon" },


  -- Mason + LSP
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "clangd", "lua_ls", "jdtls", "pyright" },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
  },

    -- Plugins con configuración independiente
  { import = "plugins.lualine" },
  { import = "plugins.treesitter" },
  { import = "plugins.coc" },
  { import = "plugins.harpoon" },
  { import = "plugins.telescope" },
  { import = "plugins.lsp" }


})
