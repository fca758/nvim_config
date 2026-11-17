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
    -- Tema
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },

    -- Todo lo que viene siendo configuración de nvim LSP
    { "neovim/nvim-lspconfig" },

    -- Autocompletado de () y {}
    { import = "plugins.minipairs" },

    -- Plugins con configuración independiente
    { import = "plugins.dashboard" },
    { import = "plugins.lualine" },
    { import = "plugins.treesitter" },
    { import = "plugins.harpoon" },
    { import = "plugins.telescope" },
    { import = "plugins.conform" },
    { import = "plugins.lsp.mason" },
    { import = "plugins.lsp.masonConfig" },
    { import = "plugins.blink" },
    { import = "plugins.dap" },
    { import = "plugins.neoscroll" },
    git = {
        url_format = "https://github.com/%s.git",
    },
})
