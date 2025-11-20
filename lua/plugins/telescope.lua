return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.1.9",
        config = function()
            local telescope = require("telescope")            
            local builtin = require('telescope.builtin')


            -- Keymaps
            vim.keymap.set('n', '<C-f>f', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<C-f>h', builtin.help_tags, { desc = 'Telescope help tags' })
        end
    }
}
