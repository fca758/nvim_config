return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        local parsers = {
            "c", "cpp", "python", "lua", "vim", "vimdoc", "markdown", "markdown_inline",
            "javascript", "jsx", "typescript", "tsx", "html", "css", "bash", "json",
            "java", "cmake",
        }

        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_user_command("TSInstallMissing", function()
            require("nvim-treesitter").install(parsers)
        end, {})

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local ft = vim.bo[args.buf].filetype
                local lang = vim.treesitter.language.get_lang(ft) or ft
                if vim.treesitter.language.add(lang) then
                    vim.treesitter.start(args.buf, lang)
                end
            end,
        })
    end,
}
