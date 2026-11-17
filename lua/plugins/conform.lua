return {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({
                    async = true,
                    lsp_format = "fallback",
                    filter = function(client)
                        return client.name ~= "pyright"
                    end,
                })
            end,
            mode = "n",
            desc = "Formatear buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            json5 = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            less = { "prettier" },
            html = { "prettier" },
            vue = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            mdx = { "prettier" },
            ["markdown.mdx"] = { "prettier" },
            graphql = { "prettier" },
            handlebars = { "prettier" },
            c = { "clang-format" },
            cpp = { "clang-format" },
        },
        formatters = {
            prettier = {
                prepend_args = { "--tab-width", "4", "--no-use-tabs" },
            },
            ["clang-format"] = {
                -- Respeta .clang-format del proyecto; sin él, usa 4 espacios.
                prepend_args = function(_, ctx)
                    local has_config = #vim.fs.find(".clang-format", {
                        path = vim.fs.dirname(ctx.filename),
                        upward = true,
                    }) > 0

                    if has_config then
                        return {}
                    end

                    return {
                        "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}",
                    }
                end,
            },
        },
    },
}
