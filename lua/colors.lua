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

