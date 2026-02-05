return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2", 
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Configuración de Keymaps básicos
        -- Agregar archivo a Harpoon
        vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })

        -- Ver el menú de Harpoon
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })

        -- Navegación rápida entre archivos marcados (1 al 4)
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-ñ>", function() harpoon:list():select(4) end)

        -- Función para que los colores sobrevivan al cambio de tema
        local function apply_highlights()
            vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
            vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
            vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
            vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
            vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')
        end

        apply_highlights() -- Aplicar al cargar

        -- Re-aplicar si cambias de tema en caliente
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = apply_highlights,
        })

    end,
}
