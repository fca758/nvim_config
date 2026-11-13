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
        automatic_enable = true,
    },
}
