return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Agregar archivo a Harpoon
        vim.keymap.set("n", "<C-e>", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })

        -- Ver el menú de Harpoon
        vim.keymap.set("n", "<C-t>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })

        -- Quitar archivo actual de Harpoon de forma segura
        vim.keymap.set("n", "<C-q>", function()
            local list = harpoon:list()
            local current_file = vim.fn.expand("%:p") -- Obtiene la ruta absoluta del buffer actual

            for _, item in ipairs(list.items) do
                -- Convierte la ruta guardada en Harpoon a absoluta para una comparación exacta
                local item_path = vim.fn.fnamemodify(item.value, ":p")
                
                if current_file == item_path then
                    list:remove(item)
                    vim.notify("Archivo removido de Harpoon", vim.log.levels.INFO)
                    break
                end
            end
        end, { desc = "Harpoon: Remove file" })

        -- Navegación rápida entre archivos marcados (1 al 4)
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })

        -- Toggle previous & next buffers
        vim.keymap.set("n", "<C-n>", function() harpoon:list():prev() end, { desc = "Harpoon: Prev file" })
        vim.keymap.set("n", "<C-p>", function() harpoon:list():next() end, { desc = "Harpoon: Next file" })

        vim.keymap.set("n", "<C-TAB>", function() harpoon:list():next() end, { desc = "Harpoon: Next file" })
    end,
}
