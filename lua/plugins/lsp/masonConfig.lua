return{
    
        "williamboman/mason-lspconfig.nvim",
    opts ={
        -- auto instalar e activar
        ensure_installed = {
            "pyright", "ruff",      -- Python
            "html", "cssls", "ts_ls", -- Web
            "clangd",               -- C/C++
            "jdtls",                -- Java
            "lua_ls"                -- Neovim config
        },

    },
}
