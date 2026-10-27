return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter').setup {
            install_dir = vim.fn.stdpath('data') .. '/site',
        }

        -- Autocmd para instalar/actualizar parsers que falten
        local parsers = {
            "c", "python", "lua", "vim", "vimdoc", "markdown", "markdown_inline",
            "javascript", "typescript", "html", "css", "bash", "json", "java",
        }
        vim.api.nvim_create_user_command("TSInstallMissing", function()
            local have = require('nvim-treesitter').get_installed()
            local set = {}
            for _, p in ipairs(have or {}) do set[p] = true end
            local missing = vim.tbl_filter(function(p) return not set[p] end, parsers)
            if #missing == 0 then
                vim.notify("Todos los parsers ya están instalados", vim.log.levels.INFO)
                return
            end
            require('nvim-treesitter.install').install(missing)
        end, {})

        -- Habilitar treesitter para todos los lenguajes que tengan parser
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
