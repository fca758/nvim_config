return{
    
        "williamboman/mason-lspconfig.nvim",
    opts ={
        -- TODO: Añadir JAVA
        -- auto instalar e activar
        ensure_installed = {
            "ts_ls",
            "html",
            "cssls",
            "lua_ls",
            "pyright",
            "clangd",
            "ruff"
        },

    },
}
