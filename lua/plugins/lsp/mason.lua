return {
    "williamboman/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "yes",
                package_pending = "??",
                package_uninstalled = "NO",
            },
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)

        local registry = require("mason-registry")
        for _, tool in ipairs({ "codelldb", "debugpy", "prettier" }) do
            local ok, pkg = pcall(registry.get_package, tool)
            if ok and not pkg:is_installed() then
                pkg:install()
            end
        end
    end,
}
