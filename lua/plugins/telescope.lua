return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.1.9",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")

            telescope.setup({
                defaults = {
                    mappings = {
                        n = {
                            ["k"] = actions.move_selection_next,
                            ["l"] = actions.move_selection_previous,
                            ["q"] = actions.close,
                            ["<C-k>"] = actions.move_selection_next,
                            ["<C-l>"] = actions.move_selection_previous,
                        },
                        i = {
                            ["<C-k>"] = actions.move_selection_next,
                            ["<C-l>"] = actions.move_selection_previous,
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            pcall(telescope.load_extension, "fzf")

            local map = vim.keymap.set

            map("n", "<leader><leader>", builtin.find_files, { desc = "Buscar archivos" })
            map("n", "<leader>ff", builtin.find_files, { desc = "Buscar archivos" })
            map("n", "<leader>fg", builtin.live_grep, { desc = "Buscar texto" })
            map("n", "<leader>fb", builtin.buffers, { desc = "Buffers abiertos" })
            map("n", "<leader>fo", builtin.oldfiles, { desc = "Archivos recientes" })
            map("n", "<leader>fh", builtin.help_tags, { desc = "Ayuda" })
            map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnósticos" })
            map("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Símbolos del documento" })
            map("n", "<leader>fr", builtin.lsp_references, { desc = "Referencias LSP" })
        end,
    },
}
