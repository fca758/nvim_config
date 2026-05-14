return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_syntax_enabled = 1
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_view_automatic = 1
        vim.g.vimtex_compiler_latexmk = {
            build_dir = "",
            options = {
                "-pdf",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
            },
        }
    end,
    keys = {
        { "<leader>ll", "<cmd>VimtexCompile<cr>", desc = "Compile LaTeX" },
        { "<leader>lv", "<cmd>vimtexView<cr>", desc = "View PDF" },
        { "<leader>lc", "<cmd>VimtexClean<cr>", desc = "Clean build files" },
        { "<leader>lk", "<cmd>vimtex-stop<cr>", desc = "Stop compilation" },
        { "<leader>le", "<cmd>vimtex-errors<cr>", desc = "Show errors" },
    },
}
