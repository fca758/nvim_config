return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.1.9",
        -- Es recomendable declarar las dependencias para evitar errores
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- Necesario si quieres usar la extensión fzf que estás configurando
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")

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
                }, -- <-- El bloque defaults cierra aquí
                
                -- El bloque extensions va al mismo nivel que defaults
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    },
                },
            })

            -- Cargar la extensión fzf después del setup
            pcall(telescope.load_extension, "fzf")

            -- Keymaps
            vim.keymap.set('n', '<C-f>F', builtin.treesitter, { desc = 'Telescope find functions' })
            vim.keymap.set('n', '<C-f>f', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set("n", "<C-f>a", function()
                builtin.find_files({
                    cwd = "~",
                    hidden = true,
                })
            end, { desc = "Buscar archivos ocultos en ~ con Telescope" })
        end
    }
}
