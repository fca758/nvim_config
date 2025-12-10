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
