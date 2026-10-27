local sysname = vim.loop.os_uname().sysname

if sysname == "Windows_NT" then
    vim.cmd("colorscheme gruvbox")
else
    vim.cmd("colorscheme onedark")
end

-- Fondo transparente

vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
vim.cmd("highlight NonText ctermbg=NONE guibg=NONE")
vim.cmd("highlight NormalFloat ctermbg=NONE guibg=NONE")
vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

-- ==========================================
-- COLORES PERSONALIZADOS PARA TODOS LOS LENGUAJES
-- ==========================================
local function custom_highlights()
    -- 1. PALABRAS CLAVE BÁSICAS (Azul oscuro)
    vim.api.nvim_set_hl(0, "@keyword", { fg = "#569cd6" })
    vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#569cd6" })
    vim.api.nvim_set_hl(0, "@keyword.coroutine", { fg = "#569cd6" })

    -- 2. PALABRAS DE CONTROL DE FLUJO (Rosa/Magenta)
    vim.api.nvim_set_hl(0, "@keyword.return", { fg = "#c586c0" })
    vim.api.nvim_set_hl(0, "@keyword.operator", { fg = "#c586c0" })
    vim.api.nvim_set_hl(0, "@keyword.import", { fg = "#c586c0" })
    vim.api.nvim_set_hl(0, "@exception", { fg = "#c586c0" })

    -- 3. FUNCIONES (Amarillo crema)
    vim.api.nvim_set_hl(0, "@function", { fg = "#dcdcaa" })
    vim.api.nvim_set_hl(0, "@function.call", { fg = "#dcdcaa" })
    vim.api.nvim_set_hl(0, "@method", { fg = "#dcdcaa" })
    vim.api.nvim_set_hl(0, "@method.call", { fg = "#dcdcaa" })

    -- 4. VARIABLES Y PROPIEDADES (Azul claro cielo)
    vim.api.nvim_set_hl(0, "@variable", { fg = "#9cdcfe" })
    vim.api.nvim_set_hl(0, "@property", { fg = "#9cdcfe" })
    vim.api.nvim_set_hl(0, "@field", { fg = "#9cdcfe" })
    vim.api.nvim_set_hl(0, "@parameter", { fg = "#9cdcfe" })

    -- 5. CADENAS DE TEXTO / STRINGS (Naranja terracota)
    vim.api.nvim_set_hl(0, "@string", { fg = "#ce9178" })

    -- 6. COMENTARIOS (Verde)
    vim.api.nvim_set_hl(0, "@comment", { fg = "#6a9955" })

    -- 7. HTML / TAGS
    vim.api.nvim_set_hl(0, "@tag", { fg = "#569cd6" })
    vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#9cdcfe" })
    vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#808080" })
end

custom_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = custom_highlights,
})

