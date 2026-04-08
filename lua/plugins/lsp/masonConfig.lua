local function get_server_config(server_name)
    local ok, server_config = pcall(require, "after.lsp." .. server_name)
    if ok then
        return server_config
    end
    return {}
end

local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require("blink.cmp").get_lsp_capabilities()
)

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
            "als",
        },
        handlers = {
            ["als"] = function()
                local config = get_server_config("als")
                require("lspconfig").als.setup(vim.tbl_deep_extend("force", { capabilities = capabilities }, config))
            end,
            function(server_name)
                local config = get_server_config(server_name)
                require("lspconfig")[server_name].setup(vim.tbl_deep_extend("force", { capabilities = capabilities }, config))
            end,
        },
    },
}
