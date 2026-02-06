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
        vim.keymap.set("n", "<C-x>", function() 
            local harpoon = require("harpoon")
            local list = harpoon:list()
            local current_file = vim.api.nvim_buf_get_name(0)

            -- Buscamos el item en la lista para eliminarlo por valor
            -- Esto fuerza a Harpoon a re-indexar la tabla interna
            for _, item in ipairs(list.items) do
                if current_file:find(item.value, 1, true) then
                    list:remove(item)
                    break
                end
            end
        end, { desc = "Harpoon: Remove file" })

        -- Ver el menú de Harpoon
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })

        -- Navegación rápida entre archivos marcados (1 al 4)
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

    end,
}
