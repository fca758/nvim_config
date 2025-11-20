local map = vim.keymap.set

-- Deshacer
map('i', '<C-z>', '<C-o>u')
map('n', '<C-z>', 'u')

-- Portapapeles
map('v', '<C-c>', '"+y')
map('n', '<C-v>', '"+p')
map('i', '<C-v>', '<C-r>+')

-- Buffers
map('n', '<C-Tab>', ':bnext<CR>', { silent = true })
map('n', '<C-S-Tab>', ':bprevious<CR>', { silent = true })


-- Ponemos las direcciones de nvim una más a la izquierda (h j k l) -> (j k l ñ)
map({"n","v","o"},"h","<nop>",{noremap=true,silent=true})
map({"n","v","o"},"j","<nop>",{noremap=true,silent=true})
map({"n","v","o"},"k","<nop>",{noremap=true,silent=true})
map({"n","v","o"},"l","<nop>",{noremap=true,silent=true})
map({"n","v","o"},"j","h",{noremap=true,silent=true})
map({"n","v","o"},"k","j",{noremap=true,silent=true})
map({"n","v","o"},"l","k",{noremap=true,silent=true})
map({"n","v","o"},"ñ","l",{noremap=true,silent=true})


map("n","<C-q>", function() vim.cmd("e .") end)
