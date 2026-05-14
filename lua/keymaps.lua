local map = vim.keymap.set

vim.g.mapleader = "º"
vim.g.maplocalleader = "º"

-- Buffers (ventanas)
map('n', '<C-I>', '<C-w><C-w>', { silent = true })


-- Ctrl + q abre el directorio actual
map("n","<C-q>", function() vim.cmd("vs .") end)

-- Copiar un archivo entero al portapapeles (WIP)
map("n", "@c", "ggVG\"+y")

-- Al escribir "nn" en modo insert de devuelve a normal 
map("i", "ff", "<esc>")

map("n", "<C-s>", function() vim.cmd(":noh") end)
