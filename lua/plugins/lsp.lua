-- plugins/lsp.lua
return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- C / C++
            vim.lsp.config("clangd", {})
            vim.lsp.enable("clangd")

            -- Lua
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        telemetry = { enable = false },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            -- Java
            vim.lsp.config("jdtls", {})
            vim.lsp.enable("jdtls")

            -- Python
            vim.lsp.config("pyright", {})
            vim.lsp.enable("pyright")
        end,
    }
}

