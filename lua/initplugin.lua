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

    -- Autocompletado
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
    },

    -- Todo lo que viene siendo configuración de nvim
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },

    {"neovim/nvim-lspconfig"},

    -- Plugins con configuración independiente
    { import = "plugins.lualine"},
    { import = "plugins.treesitter"},
    { import = "plugins.harpoon"},
    { import = "plugins.telescope"},
    { import = "plugins.lsp.mason" },
    { import = "plugins.lsp.masonConfig" }

})


