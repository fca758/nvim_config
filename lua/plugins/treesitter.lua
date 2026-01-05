return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    build = ":TSUpdate",  -- actualiza los parsers automáticamente
    config = function()
        require('nvim-treesitter.install').prefer_git = true  -- usa git para instalar parsers
        require 'nvim-treesitter.configs'.setup {
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            
            ensure_installed = { 
                "c",
                "python",
                "lua",
                "vim",
                "vimdoc",
                "markdown",
                "markdown_inline" ,
                "javascript",
                "typescript",
                "html",
                "css",
                "bash",
                "json",
                "java",
            },



            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
                enable = true,

                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        }
        -- ==========================================
        -- COLORES PERSONALIZADOS PARA TODOS LOS LENGUAJES
        -- ==========================================
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
                -- 1. PALABRAS CLAVE BÁSICAS (Azul oscuro)
                -- Para: const, let, function, if, else, try, async
                vim.api.nvim_set_hl(0, "@keyword", { fg = "#569cd6" })
                vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#569cd6" })
                vim.api.nvim_set_hl(0, "@keyword.coroutine", { fg = "#569cd6" }) -- async

                -- 2. PALABRAS DE CONTROL DE FLUJO (Rosa/Magenta)
                -- Para: return, await, throw, import, from, new
                vim.api.nvim_set_hl(0, "@keyword.return", { fg = "#c586c0" })
                vim.api.nvim_set_hl(0, "@keyword.operator", { fg = "#c586c0" }) -- new, await
                vim.api.nvim_set_hl(0, "@keyword.import", { fg = "#c586c0" })
                vim.api.nvim_set_hl(0, "@exception", { fg = "#c586c0" }) -- throw

                -- 3. FUNCIONES (Amarillo crema)
                -- Para: removeMember, getApi, renderLayout
                vim.api.nvim_set_hl(0, "@function", { fg = "#dcdcaa" })
                vim.api.nvim_set_hl(0, "@function.call", { fg = "#dcdcaa" })
                vim.api.nvim_set_hl(0, "@method", { fg = "#dcdcaa" })
                vim.api.nvim_set_hl(0, "@method.call", { fg = "#dcdcaa" })

                -- 4. VARIABLES Y PROPIEDADES (Azul claro cielo)
                -- Para: listId, memberId, api, list.members
                vim.api.nvim_set_hl(0, "@variable", { fg = "#9cdcfe" })
                vim.api.nvim_set_hl(0, "@property", { fg = "#9cdcfe" })
                vim.api.nvim_set_hl(0, "@field", { fg = "#9cdcfe" })
                vim.api.nvim_set_hl(0, "@parameter", { fg = "#9cdcfe" }) -- Argumentos

                -- 5. CADENAS DE TEXTO / STRINGS (Naranja terracota)
                -- Para: 'List not found', "dashboard-header"
                vim.api.nvim_set_hl(0, "@string", { fg = "#ce9178" })

                -- 6. COMENTARIOS (Verde)
                -- Para: // UI rendering
                vim.api.nvim_set_hl(0, "@comment", { fg = "#6a9955"})

                -- 7. HTML / TAGS (Para el código dentro de tu renderLayout)
                -- <div, <h2, <p (Azul como las keywords)
                vim.api.nvim_set_hl(0, "@tag", { fg = "#569cd6" }) 
                -- class=, style=, id= (Azul claro como variables)
                vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#9cdcfe" }) 
                -- < > (Gris o Blanco para los delimitadores)
                vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#808080" }) 
            end,
        })
    end,
}
