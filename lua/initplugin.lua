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

    -- Autocomentarios
    { "numToStr/Comment.nvim", opts = {} },

    -- Cursor animado
    -- { "sphamba/smear-cursor.nvim", opts = {} },

    -- FuzzyFinder
    { "nvim-telescope/telescope.nvim", tag = "v0.1.9"},

    -- Cambiar entre ventanas
    { "ThePrimeagen/harpoon" },


    -- Todo lo que viene siendo configuración de nvim LSP
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    -- IDEM
    {"neovim/nvim-lspconfig"},

    -- Autocompletado
    {"Saghen/blink.cmp"},

    -- Autocompletado de () y {}
    { import = "plugins.minipairs"},

    -- Plugins con configuración independiente
    { import = "plugins.lualine"},
    { import = "plugins.treesitter"},
    { import = "plugins.harpoon"},
    { import = "plugins.telescope"},
    { import = "plugins.lsp.mason" },
    { import = "plugins.lsp.masonConfig" },
    { import = "plugins.blink" },

})

