return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
        ensure_installed = {
            "pyright",
            "ruff",
            "html",
            "cssls",
            "ts_ls",
            "clangd",
            "jdtls",
            "lua_ls",
        },
        handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup({})
            end,
        },
    },
}
