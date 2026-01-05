return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.1.9",
        config = function()
            local telescope = require("telescope")            
            local actions = require("telescope.actions")
            local builtin = require('telescope.builtin')

            telescope.setup({
                defaults = {
                    mappings = {
                        n = { -- NORMAL MODE dentro de Telescope
                            ["k"] = actions.move_selection_next,
                            ["l"] = actions.move_selection_previous,
                            ["q"] = actions.close,
                            ["<C-k>"] = actions.move_selection_next,
                            ["<C-l>"] = actions.move_selection_previous,
                        },
                        i = { -- INSERT MODE dentro de Telescope
                            ["<C-k>"] = actions.move_selection_next,
                            ["<C-l>"] = actions.move_selection_previous,
                        },
                    },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    },
                },
                
                    -- SOLO PARA TW_GSA
                    file_ignore_patterns ={
                        "FrontendCliente/*",
                        "api/*",
                        "api_rest/vendor/*",
                        "api_rest/src/Helpers/*",
                        "api_rest/src/Modules/Middleware/*",
                        "api_rest/src/Modules/Articulos/*",
                        "api_rest/src/Modules/Login/*",
                        "%.md",
                        "%.sql",
                        "%.json",
                        "%.png",
                        "%.jpg",
                        "%.jpeg",
                        "%.lock",
                        "%.txt"

                    },
                },
            })
            -- Keymaps
            vim.keymap.set('n', '<C-f>f', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<C-f>h', builtin.help_tags, { desc = 'Telescope help tags' })
            vim.keymap.set("n", "<C-f>a", function()
                require("telescope.builtin").find_files({
                    cwd = "~",
                    hidden = true,
               })
            end, { desc = "Buscar archivos con Telescope" })

        end
    }
}
